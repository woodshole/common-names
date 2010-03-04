ActionController::Routing::Routes.draw do |map|
  map.resource :user_session
  map.resources :users
  
  map.resources :taxa, :collection => { :data => :get }
  # map.with_options :controller => :lifespans do |a|
  #   a.new_lifespan '/species/:species_id/lifespans/new', :action => :new, :conditions => {:method => :get}
  #   a.edit_lifespan '/species/:species_id/lifespans/:id/edit', :action => :edit, :conditions => {:method => :get}
  #   a.connect '/species/:species_id/lifespans', :action => :create, :conditions => {:method => :post}
  #   a.connect '/species/:species_id/lifespans/:id', :action => :update, :conditions => {:method => :put}
  # end
  
  
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
