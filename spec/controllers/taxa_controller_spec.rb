require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TaxaController do
  
  describe "index" do
    before(:all) do
      root = mock_model(Taxon)
      root.stub!(:id).and_return(1)
      Taxon.stub!(:root).and_return(root)
    end
    it "should find the root and render the index template" do
      get :index
      response.should render_template("taxa/index.haml")
    end
  end
  
  describe "show" do
    integrate_views
    before(:each) do
      taxon = mock_model(Taxon)
      #all
      taxon.stub!(:dropdown_options).with('all', nil).and_return([['Annelida', 3],['Agmata', 8]])
      #common
      taxon.stub!(:dropdown_options).with('common', nil).and_return([['Worms', 3]])
      #scientific
      taxon.stub!(:dropdown_options).with('scientific', nil).and_return([['Agmata', 8]])
      Taxon.stub!(:find).and_return(nil)
      Taxon.should_receive(:find).with('2').and_return(taxon)
    end
    it "should return a list of children given a parent_id" do
      get :show, :id => '2', :filter => 'all', :rank => 'kingdom'
      response.should render_template('taxa/show.haml')
      response.should have_tag("option", :text => "Any", :value => "")
      response.should have_tag("option", :text => "Annelida", :value => "3")
    end
    it "should return a list of children in common_names if filter is common" do
      get :show, :id => '2', :filter => 'common', :rank => 'kingdom'
      response.should render_template('taxa/show.haml')
      response.should_not have_tag("option", :text => "Obrúčkavce", :value => "3")
      response.should have_tag("option", :text => "Worms", :value => "3")
    end
    it "should return a list of children with no common_names if filter is scientific" do
      get :show, :id => '2', :filter => 'scientific', :rank => 'kingdom'
      response.should render_template('taxa/show.haml')
      response.should_not have_tag("option", :text => "Worms", :value => "3")
      response.should_not have_tag("option", :text => "Obrúčkavce", :value => "3")
      response.should have_tag ("option", :text => "Agmata", :value => "8")
    end
  end
  
  describe "stats" do
    integrate_views
    before(:each) do
      taxon = mock_model(Taxon)
      lang_slo = mock_model(Language)
      lang_slo.stub!(:english_name).and_return("Slovak")
      lang_eng = mock_model(Language)
      lang_eng.stub!(:english_name).and_return("English")
      lang_slo.stub!(:lang_id).and_return(0)
      lang_eng.stub!(:lang_id).and_return(0)
      taxon.stub!(:get_count_of_children_translated).with(nil).and_return(10)
      taxon.stub!(:get_languages_of_children).and_return([lang_slo,lang_eng])
      taxon.stub!(:get_number_of_children).and_return(7)
      taxon.stub!(:percent_of_children_with_common_name).and_return("10.00%")
      Taxon.stub!(:find).and_return(nil)
      Taxon.should_receive(:find).with('2').and_return(taxon)
      Language.stub!(:find).and_return(nil)
    end
    it "should render the stats partial" do
      get :stats, :taxon_id => '2'
      response.should render_template('language/_stats.haml')
    end
  end
  
end