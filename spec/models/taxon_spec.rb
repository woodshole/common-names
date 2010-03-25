require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Taxon do
  fixtures :taxa
  
  before(:each) do    
    # Set lft and rgt values for every taxon. Necessary!
    Taxon.rebuild!
    Taxon.rebuild_lineages!
  end
  
  describe "#rebuild_lineage_ids" do
    before(:each) do
      @family = Taxon.find(6)
      @taxon = Taxon.new(:name => "Genus 2", :rank => 5, :parent_id => @family.id)
      @taxon.save!
    end
    it "should set lineage_ids to the correct values" do
      @taxon.lineage_ids.should == "1,2,3,4,5,6"
    end
  end
  
  describe ".rebuild_lineages!" do
    it "should build lineage_ids for every taxon in system" do
      Taxon.find(2).lineage_ids.should == "1"
      Taxon.find(3).lineage_ids.should == "1,2"
      Taxon.find(4).lineage_ids.should == "1,2,3"
      Taxon.find(5).lineage_ids.should == "1,2,3,4"
      Taxon.find(6).lineage_ids.should == "1,2,3,4,5"
      Taxon.find(7).lineage_ids.should == "1,2,3,4,5,6"
      Taxon.find(8).lineage_ids.should == "1,2,3,4,5,6,7"
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

