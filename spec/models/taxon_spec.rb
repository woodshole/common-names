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
  
  describe "dropdown_options(filt, language)" do
    it "should return scientific names of children if filt is none" do
      taxa = Taxon.find(2).dropdown_options('none',nil)
      taxa.should include(['Annelida', 3])
      taxa.should include(['Agmata', 8])
    end
    it "should only return common names in a given language if filt is common" do
      taxa = Taxon.find(2).dropdown_options('common',Language.find(1))
      taxa.should include(['Worms', 3])
      Taxon.find(8).common_names.should be_empty
    end
    it "should only return names with no common names if filt is scientific" do
      taxa = Taxon.find(11).dropdown_options('scientific', nil)
      taxa.should include(['Haplotaxida', 12])
      taxa.should include(['Moniligastrida', 13])
      Taxon.find(12).common_names.should be_empty
      Taxon.find(13).common_names.should be_empty
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
  
  describe "has_common_name?" do
    it "should return true if there is a common name" do
      Taxon.find(5).has_common_name?.should be_true
    end
    it "should return false if there is no common name" do
      Taxon.find(9).has_common_name?.should be_false
    end
  end
  
  describe "common_names_list(filt, language)" do
    it "should return all common names if language and filt is nil" do
      cns = Taxon.find(3).common_names_list('none', nil).collect{|t| t.name}
      cns.should include('Obrúčkavce')
      cns.should include('Worms')
    end
    it "should return only common names in a given language" do
      cns = Taxon.find(2).common_names_list('only', Language.find(3)).collect{|t| t.name}
      cns.should include('Animales')
    end
  end
  
  describe "self.root" do
    it "should return the root taxon" do
      Taxon.root.id.should == 1
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

