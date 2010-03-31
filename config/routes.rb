ActionController::Routing::Routes.draw do |map|
  map.resource :user_session
  map.resources :users
  map.resources :common_names
  map.resources :photos
  
  map.resources :taxa, :collection => { :data => :get }
  map.language  '/language/:language', :controller => :taxa
  
  # AJAX Navigation
  map.best_photo '/best_photo',
    :controller => :photos,
    :action => :best,
    :conditions => {:method => :get}
  
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