require 'spec_helper'

describe Photo do
  before(:each) do
    @valid_attributes = {
      :url => "value for url",
      :taxon_id => 2
    }
  end
  validates_presence_of :url, :taxon_id
  validates_uniqueness_of :url, :scope => [:taxon_id]
  

  it "should create a new instance given valid attributes" do
    photo = Photo.create(@valid_attributes)
    photo.should
  end
  
  it "should be able to create a Flickr object by reading the flickr.yml file" do
    flicka = Photo.flickr
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

