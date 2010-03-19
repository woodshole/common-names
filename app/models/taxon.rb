# == Schema Information
#
# Table name: taxa
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  parent_id   :integer
#  lft         :integer
#  rgt         :integer
#  rank        :integer
#  lineage_ids :string(255)
#

class Taxon < ActiveRecord::Base
  acts_as_nested_set
  
  has_many :common_names
  
  before_save :rebuild_lineage_ids
  
  named_scope :kingdom, lambda { |conditions| conditions ||= {}; {:conditions => {:rank => 0}.merge(conditions), :order => :name} }
  named_scope :phylum,  lambda { |conditions| conditions ||= {}; {:conditions => {:rank => 1}.merge(conditions), :order => :name} }
  named_scope :class,  lambda { |conditions| conditions ||= {}; {:conditions => {:rank => 2}.merge(conditions), :order => :name} }
  named_scope :order,   lambda { |conditions| conditions ||= {}; {:conditions => {:rank => 3}.merge(conditions), :order => :name} }
  named_scope :family, lambda { |conditions| conditions ||= {}; {:conditions => {:rank => 4}.merge(conditions), :order => :name} }
  
  validates_presence_of :rank, :message => "must be set"
  validates_presence_of :name, :message => "can't be blank"
  
  # def paginated_sorted_names(page)
  #   begin
  #     Taxon.paginate_by_sql("SELECT name FROM taxa WHERE lft >= #{self.lft} AND rgt <= #{self.rgt} ORDER BY name ASC", :page => page)
  #   rescue
  #     raise "Left and Right attributes were nil!"
  #   end
  # end
  
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
