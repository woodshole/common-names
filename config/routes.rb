ActionController::Routing::Routes.draw do |map|
  map.resource :user_session
  map.resources :users
  map.resources :common_names
  map.resources :photos
  
 # map.resources :common_names, :collection => { :data => :get }
  map.language  '/language/:language', :controller => :taxa
  
  # AJAX Navigation
  map.taxonomy_dropdown '/taxonomy/dropdown/:rank', 
    :controller => :taxonomy_navigation, 
    :action => :dropdown_options, 
    :rank => /(kingdom|phylum|class|order|family)/,
    :conditions => {:method => :get}
  
  map.taxon '/:rank/:taxon',
    :controller => :taxa,
    :action => :index,
    :rank => /(kingdom|phylum|class|order|family)/,
    :conditions => {:method => :get}
  
  map.root :controller => :taxa
end