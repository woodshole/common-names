require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
describe Language do
  fixtures :taxa, :common_names, :languages
  
  before(:all) do
    Taxon.rebuild!
    Taxon.rebuild_lineages!
  end
  
  describe "to_s" do
    it "should return the language's english name" do
      Language.find(2).to_s.should == "Slovak"
      Language.find(3).to_s.should == Language.find(3).english_name
    end
  end
  
  describe "Language.active_languages" do
    it "sould return an array of languages that have at least one common name associated with them" do
      langs = Language.active_languages.collect{|l| l.english_name}
      langs.should include(Language.find(1).english_name)
      langs.should include(Language.find(3).english_name)
    end
  end
  
end
#   before(:each) do
#     @valid_attributes = {
#       :iso_code => "value for iso_code",
#       :english_name => "value for english_name"
#     }
#   end
# 
#   it "should create a new instance given valid attributes" do
#     Language.create!(@valid_attributes)
#   end
# end

# == Schema Information
#
# Table name: languages
#
#  id           :integer(4)      not null, primary key
#  iso_code     :string(255)
#  english_name :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

