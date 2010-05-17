require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Photo do
  fixtures :taxa, :users, :photos
  
  describe "Photo.flickr" do
    it "should return an instance of Flickr" do
      Photo.flickr.should_not == nil
    end    
  end
  
  describe "only_preferred" do
    it "should only have one preferred photo at a time" do
      photos = Photo.find(:all, :conditions => "taxon_id = 5")
      count = 0
      photos.each do |photo|
        count += 1 if photo.preferred
      end
      count.should == 1
    end
    
    it "should return most recently added as the preferred" do
      p = Photo.create!(:url => "http://google.com", :taxon_id => 5, :preferred => 1)
      p.only_preferred
      photos = Photo.find(:all, :conditions => "taxon_id = 5")
      count = 0
      photos.each do |photo|
        count += 1 if photo.preferred
      end
      count.should == 1
      Photo.find_by_taxon_id(5, :conditions => "preferred = 1").url.should == "http://google.com"
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

