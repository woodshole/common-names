class Photo < ActiveRecord::Base
  has_and_belongs_to_many :users
  belongs_to :taxon
  
  validates_presence_of :url, :taxon_id
  validates_uniqueness_of :url
  
  def only_preferred
    Photo.find(:all, :conditions => "taxon_id = #{self.taxon_id} AND id <> #{self.id}").each do |photo|
      photo.preferred = 0
      photo.save
    end
  end
  
  def self.preferred(taxon)
    begin
      Photo.find(1, :conditions => "taxon_id => #{Taxon.find_by_name(taxon).id} AND preferred = 1")
    rescue
      Photo.find_by_taxon_id(Taxon.find_by_name(taxon).id)
    end
  end
end
