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
  
  def common_names_list(filt, language)
    if filt == 'all' 
      Taxon.find_by_sql("SELECT languages.english_name as lang, 
          common_names.name as name, 
          users.email as user, 
          common_names.source as source,
          common_names.id as id
        FROM common_names
        LEFT JOIN languages
        ON common_names.language_id = languages.id
        LEFT JOIN users
        ON common_names.user_id = users.id
        WHERE common_names.taxon_id = #{self.id}
        ORDER BY common_names.name")
    elsif filt == 'only'
      Taxon.find_by_sql("SELECT languages.english_name as lang, 
          common_names.name as name, 
          users.email as user, 
          common_names.source as source,
          common_names.id as id
        FROM common_names
        LEFT JOIN languages
        ON common_names.language_id = languages.id
        LEFT JOIN users
        ON common_names.user_id = users.id
        WHERE common_names.taxon_id = #{self.id}
        AND common_names.language_id = #{language.id}
        ORDER BY common_names.name")
    end
  end
  
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
  
  def has_common_name?
    not self.common_names.empty?
  end
  
  def dropdown_options(rank, filt,language)
    if filt == "common"
      taxa = Taxon.find_by_sql("SELECT taxa.id as id, common_names.name as common
      	FROM taxa
      	LEFT JOIN common_names
      	ON taxa.id = common_names.taxon_id
      	WHERE taxa.parent_id = #{self.id}
      	AND taxa.rank = #{self.rank + 1}
      	AND common_names.name IS NOT NULL
      	AND common_names.language_id = #{language.id}
      	GROUP BY taxa.name")
    elsif filt == "scientific"
      taxa = Taxon.find_by_sql("SELECT taxa.id as id, taxa.name as name
      	FROM taxa
      	LEFT JOIN common_names
      	ON taxa.id = common_names.taxon_id
      	WHERE taxa.parent_id = #{self.id}
      	AND taxa.rank = #{self.rank + 1}
      	AND common_names.name IS NULL
      	GROUP BY taxa.name")
    else
      taxa = Taxon.send(rank, :parent_id => self.id)
    end
      
    if filt == 'common'
      taxa.map! {|t| [t.common, t.id] }
    else
      taxa.map! {|t| [t.name, t.id]}
    end
    taxa.unshift(['Any', ''])
  end
    
  #   # SQL:
  #   # SELECT 
  #   
  #   #get children taxa
  #   taxa = Taxon.send(rank, :parent_id => self.id)
  #   unless filt == "none"
  #     to_del = []
  #     taxa.each do |t|
  #       # if we only want to see those with common names and this taxon does not have a common name
  #       # delete it
  #       if filt == 'common' and not t.has_common_name?
  #         to_del << t
  #       # if we only want to see those without common names and this taxon has a common name
  #       # delete it
  #       elsif filt == 'scientific' and t.has_common_name?
  #         to_del << t
  #       end
  #     end
  #     to_del.each {|t| taxa.delete t}
  #   else
  #     taxa.map! {|t| [t.name, t.id]}
  #   end
  #   if filt == 'common'
  #     taxa.map! {|t| [t.common_names[0].name, t.id] }
  #   elsif filt == 'scientific'
  #     taxa.map! {|t| [t.name, t.id]}
  #   end
  #   taxa.unshift(['Any', ''])
  # end
  # 
  def parents
    lineage_ids.split(/,/).collect { |ancestor_id| Taxon.find(ancestor_id) }
  end
  
  # Rebuild lineage_ids for this taxon.
  def rebuild_lineage_ids
    unless parent_id.nil? || parent.lineage_ids.blank?
      self.lineage_ids = (parent.lineage_ids + "," + parent_id.to_s)
    end
  end
  
  # Redefining our own 'root' method, which should run much faster...
  def self.root
    find(1)
  end
  
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
