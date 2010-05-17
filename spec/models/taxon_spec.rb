require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Taxon do
  fixtures :taxa, :common_names, :languages
  
  before(:each) do    
    # Set lft and rgt values for every taxon. Necessary!
    Taxon.rebuild!
    Taxon.rebuild_lineages!
  end
  
  describe "#rebuild_lineage_ids" do
    before(:each) do
      family = Taxon.find(10)
      @taxon = Taxon.new(:name => "classy", :rank => 2, :parent_id => family.id)
      @taxon.save!
    end
    it "should set lineage_ids to the correct values" do
      @taxon.lineage_ids.should == "1,7,10"
    end
  end
  
  describe ".rebuild_lineages!" do
    it "should build lineage_ids for every taxon in system" do
      Taxon.find(6).lineage_ids.should == "1,7,9,4,5"
      Taxon.find(15).lineage_ids.should == "1,2,3,11,12"
    end
  end
  
  describe "get_number_of_children" do
    it "should return the proper count of children" do
      Taxon.find(2).get_number_of_children == 7
    end
  end
  
  describe "machine_tag" do
    it "should return the machine tag to search flickr with" do
      Taxon.find(13).machine_tag.should == "taxonomy:order=Moniligastrida"
      Taxon.find(7).machine_tag.should == "taxonomy:kingdom=Fungi"
    end
  end
  
  describe "parents" do
    it "should return a comma delimited list of parents" do
      Taxon.find(5).parents.should include(Taxon.find(9))
    end
  end
  
  describe "get_languages_of_children" do
    it "should return all the languages of all children" do
      languages = Taxon.find(2).get_languages_of_children.collect {|x| x.english_name}
      languages.should include(Language.find(1).english_name)
      languages.should include(Language.find(2).english_name)
    end
  end
  
  describe "get_count_of_children_translated" do
    it "should count all children with common names in any language" do
      Taxon.find(2).get_count_of_children_translated.to_i.should == 2
    end
    it "should count all children with common names in a given language" do
      Taxon.find(7).get_count_of_children_translated(Language.find(3)).to_i.should == 1
    end
  end
  
  describe "percent_of_children_with_common_name" do
    it "should return a formatted string with a percent sign" do
      Taxon.find(2).percent_of_children_with_common_name.should == sprintf("%.2f%%",(2.0/7.0)*100)
    end
    it "should return a string if there are no children" do
      Taxon.find(13).percent_of_children_with_common_name.should == "There are no children of this taxon"
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

