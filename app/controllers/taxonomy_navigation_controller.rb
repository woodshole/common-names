# Handles all of the AJAX requests from taxonomy navigation.
class TaxonomyNavigationController < ApplicationController
  
  before_filter :set_current_language
  
  # Returns the set of options for a select field based on the parent id.
  #
  #   GET /taxonomy/dropdown/orders?class=32
  def dropdown_options
    @taxons = Taxon.send(params[:rank], :parent_id => params[:id])
    render :layout => false
  end

private
  
  def set_current_language
    @language = current_language
  end

end