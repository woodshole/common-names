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
  
  def dropdown_options(rank)
      # if current_filter
      #   # Map to sets of names and ids.
      #   elements = []
      #   taxons.each do |t|
      #     # Check to see if we're filtering taxa by common names, and skip loop if filter doesn't allow this taxon.
      #     next if current_filter == "common" && t.language_common_names(current_language).empty?
      #     next if current_filter == "scientific"  && ! t.language_common_names(current_language).empty?
      #   
      #     # If there are no common names, surround the scientific name with parentheses.
      #     if t.language_common_names(current_language).empty?
      #       text = "(" + t.name + ")"
      #     else
      #       text = t.language_common_names(current_language)[0].name
      #     end
      #     # save this mini array for each elementa
      #     elements << [text, t.id]
      #   end
      # else
      #   elements = taxons.map { |t| [t.name, t.id] }
      # end
      #   
    taxa = Taxon.send(rank, :parent_id => self.id)
    taxa.map! {|t| [t.name, t.id]}
    taxa.unshift(['Any', ''])
  end
  
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

