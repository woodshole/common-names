class Photo < ActiveRecord::Base
  has_and_belongs_to_many :users
  belongs_to :taxon
  
  validates_presence_of :url, :taxon_id
  validates_uniqueness_of :url, :scope => [:taxon_id]
  
  def self.flickr
    @flickr ||= Flickr.new(File.join(RAILS_ROOT, 'config', 'flickr.yml'))
  end
  
  #ensures we only have one preferred photo per taxon
  def only_preferred
    Photo.find(:all, :conditions => "taxon_id = #{self.taxon_id} AND id <> #{self.id}").each do |photo|
      photo.preferred = 0
      photo.save
    end
  end
  
end

# == Schema Information
#
# Table name: photos
#
#  id         :integer(4)      not null, primary key
#  url        :string(255)
#  preferred  :boolean(1)
#  created_at :datetime
#  updated_at :datetime
#  taxon_id   :integer(4)
#

