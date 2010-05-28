class Taxon < ActiveRecord::Base
  acts_as_nested_set
  has_many :photos
  has_many :common_names
  
  before_save :rebuild_lineage_ids
  
  named_scope :kingdom, lambda { |conditions| conditions ||= {}; {:conditions => {:rank => 0}.merge(conditions), :order => :name} }
  named_scope :phylum,  lambda { |conditions| conditions ||= {}; {:conditions => {:rank => 1}.merge(conditions), :order => :name} }
  named_scope :class,  lambda { |conditions| conditions ||= {}; {:conditions => {:rank => 2}.merge(conditions), :order => :name} }
  named_scope :order,   lambda { |conditions| conditions ||= {}; {:conditions => {:rank => 3}.merge(conditions), :order => :name} }
  named_scope :family, lambda { |conditions| conditions ||= {}; {:conditions => {:rank => 4}.merge(conditions), :order => :name} }
  
  validates_presence_of :rank, :message => "must be set"
  validates_presence_of :name, :message => "can't be blank"
  
  def preferred_photo
    begin
      Photo.find(:first, :limit => 1, :conditions => "taxon_id = #{self.id} AND preferred = 1")
    rescue
      Photo.find_by_taxon_id(id)
    end
  end
  #tested
  def percent_of_children_with_common_name
    count = self.get_number_of_children.to_f
    trans_count = self.get_count_of_children_translated.to_f
    return sprintf("%.2f%%", (trans_count/count)*100) unless count == 0.0
    "There are no children of this taxon"
  end
  #tested
  def get_languages_of_children
    # I don't think the right and left join are necessary here, in fact I think
    # they are slower than just doing an inner join -- RMS
    sql = "SELECT DISTINCT common_names.language_id as lang_id,
      languages.english_name as english_name
    FROM taxa
    RIGHT JOIN common_names
    ON common_names.taxon_id = taxa.id
    LEFT JOIN languages
    ON common_names.language_id = languages.id
    WHERE lft > #{self.lft} AND rgt < #{self.rgt}"
    Language.find_by_sql(sql)
  end
  
  # Returns the number of child taxa that have common names in each language
  def get_language_coverage
    sql = "SELECT COUNT(DISTINCT taxa.id) as common_name_count,
                  languages.english_name as english_name
           FROM taxa
           INNER JOIN common_names 
                   ON common_names.taxon_id = taxa.id
           INNER JOIN languages
                   ON common_names.language_id = languages.id
           WHERE lft > #{self.lft} 
             AND rgt < #{self.rgt}
           GROUP BY english_name
           ORDER BY common_name_count DESC"
    Language.find_by_sql(sql)
  end
  
  #tested
  def get_count_of_children_translated(language=nil)
    sql = "SELECT COUNT(DISTINCT taxa.id) as number_of_children
    FROM taxa
    RIGHT JOIN common_names
    ON common_names.taxon_id = taxa.id
    WHERE lft > #{self.lft} AND rgt < #{self.rgt}"
    sql += " AND common_names.language_id = #{language.id}" unless language.nil?
    Taxon.find_by_sql(sql)[0].number_of_children
  end
  #tested
  def get_number_of_children
    Taxon.find_by_sql("SELECT COUNT(id) as count
    FROM taxa
    WHERE lft > #{self.lft} AND rgt < #{self.rgt}").first.count
  end
  #tested
  def common_names_list(filt, language)
    filt = 'none' if filt.nil?
    filt = filt.downcase
    sql = "SELECT languages.english_name as lang,
      common_names.name as name,
      users.email as user,
      common_names.source as source,
      common_names.id as id
    FROM common_names
    LEFT JOIN languages
    ON common_names.language_id = languages.id
    LEFT JOIN users
    ON common_names.user_id = users.id
    WHERE common_names.taxon_id = #{self.id}"
    sql = sql + " AND common_names.language_id = #{language.id}" if filt == "only" and not language.nil?
    Taxon.find_by_sql(sql)
  end
  #tested
  def machine_tag
    case self.rank
      when 0
        rank = "kingdom"
      when 1
        rank = "phylum"
      when 2
        rank = "class"
      when 3
        rank = "order"
      when 4
        rank = "family"
    end
    "taxonomy:#{rank}=#{self.name}"
  end
  #tested
  def has_common_name?
    not self.common_names.empty?
  end
  #tested
  def dropdown_options(filt, language)
    sql = "SELECT taxa.id as id, taxa.name as name"
    sql += ", common_names.name as common" if filt == 'common'
    sql += " FROM taxa"
    sql += " LEFT JOIN common_names	ON taxa.id = common_names.taxon_id" unless filt == 'none'
    sql += " WHERE taxa.parent_id = #{self.id} AND taxa.rank = #{self.rank + 1}"
    sql += " AND common_names.name IS NOT NULL
      AND common_names.language_id = #{language.id}" if filt == 'common'
    sql += " AND common_names.name IS NULL" if filt == 'scientific'
    sql += " GROUP BY taxa.name"
    taxa = Taxon.find_by_sql(sql)
    return taxa.map! {|t| [t.common, t.id]} if filt == 'common'
    return taxa.map! {|t| [t.name, t.id]} unless filt == 'common'
  end
  #tested
  def parents
    lineage_ids.split(/,/).collect { |ancestor_id| Taxon.find(ancestor_id) }
  end
  #tested  
  # Rebuild lineage_ids for this taxon.
  def rebuild_lineage_ids
    unless parent_id.nil? || parent.lineage_ids.blank?
      self.lineage_ids = (parent.lineage_ids + "," + parent_id.to_s)
    end
  end
  #tested
  # Redefining our own 'root' method, which should run much faster...
  def self.root
    find(1)
  end
  #tested
  # This method rebuilds lineage_ids for the entire taxonomy.
  def self.rebuild_lineages!
    Taxon.find(1).rebuild_lineage_branch(nil) # Run rebuild_lineage on root node.
  end

  # This is a recursive method to rebuild a tree of lineage_ids.
  def rebuild_lineage_branch(parent_id, parent_lineage_ids="")
    lineage_ids = if parent_id.nil?  # Root node
                    ""
                  elsif parent_lineage_ids == "" || parent_id == 1 # Child of root node
                    "1"
                  else
                    parent_lineage_ids + "," + parent_id.to_s
                  end     
    
    update_attributes(:lineage_ids => lineage_ids)
    
    unless leaf?
      children.each {|child| child.rebuild_lineage_branch(id, lineage_ids)}
    end
  end
  
end

# == Schema Information
#
# Table name: taxa
#
#  id          :integer(4)      not null, primary key
#  name        :string(255)
#  parent_id   :integer(4)
#  lft         :integer(4)
#  rgt         :integer(4)
#  rank        :integer(4)
#  lineage_ids :string(255)
#
  # 
  # # Check to see if we're filtering taxa by common names, and skip loop if filter doesn't allow this taxon.
  # next if current_filter == "common" && t.language_common_names(current_language).empty?
  # next if current_filter == "scientific"  && ! t.language_common_names(current_language).empty?  
  # # If there are no common names, surround the scientific name with parentheses.
  # if t.language_common_names(current_language).empty?
  #   text = "(" + t.name + ")"
  # else
  #   text = t.language_common_names(current_language)[0].name
  # end
  # # save this mini array for each elementa
  # elements << [text, t.id]
