ActionController::Routing::Routes.draw do |map|
  map.resource :user_session
  map.resources :users
  
  map.resources :taxa, :collection => { :data => :get }
  
  # AJAX Navigation
  map.taxonomy_dropdown '/taxonomy/dropdown/:rank', 
    :controller => :taxonomy_navigation, 
    :action => :dropdown_options, 
    :rank => /(kingdoms|phylums|classes|orders|families)/,
    :conditions => {:method => :get}
  
  map.taxon '/:rank/:taxon',
    :controller => :taxa,
    :action => :index,
    :rank => /(kingdom|phylum|class|order|family)/,
    :conditions => {:method => :get}
  
  map.root :controller => :taxa
end
