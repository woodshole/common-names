ActionController::Routing::Routes.draw do |map|
  map.resource :user_session
  map.resources :users
  map.resources :common_names
  map.resources :photos
  
  # AJAX Navigation
  map.taxonomy_dropdown '/taxa/:rank', 
    :controller => :taxa, 
    :action => :show, 
    :rank => /(kingdom|phylum|class|order|family)/
  
  map.taxon '/:rank/:taxon',
    :controller => :taxa,
    :action => :index,
    :rank => /(kingdom|phylum|class|order|family)/,
    :conditions => {:method => :get}
    
  map.stats '/stats/:taxon_id',
    :controller => :taxa,
    :action => :stats
  
  map.root :controller => :taxa
end