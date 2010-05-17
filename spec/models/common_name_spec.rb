require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CommonName do
  fixtures :taxa, :common_names, :languages, :users
  
  describe "owned_by?" do
    it "should return true if the user owns the common_name" do
      owner = User.find(1)
      CommonName.find(1).owned_by?(owner).should == true
    end
    it "should return false if the user does not own it" do
      CommonName.find(4).owned_by?(User.find(2)).should == false
    end
  end
  
  describe "self.language_filter(taxa=nil, language=nil)" do
    it "should return all common names if no language is specified" do
      cns = CommonName.language_filter(Taxon.find(3)).collect {|cn| cn.name}
      cns.should include("Worms")
      cns.should include("Obrúčkavce")
    end
    it "should return all common names in a given language if a language is specified" do
      name = CommonName.language_filter(Taxon.find(2), Language.find(1)).first.name
      cn = CommonName.find_by_name(name)
      cn.language_id.should == 1
      cn.name.should_not == "Obrúčkavce"
    end
  end

end