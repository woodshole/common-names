# Handles all of the AJAX requests from taxonomy navigation.
class TaxonomyNavigationController < ApplicationController
  # Returns the set of options for a select field based on the parent id.
  #
  #   GET /taxonomy/dropdown/orders?class=32
  def dropdown_options
    session[:language] ||= params[:language]
    session[:filter] ||= params[:filter]
    id = Taxon.find_by_name(params[:parent_name]).id
    @taxons = Taxon.send(params[:rank], :parent_id => id)
    render :layout => false
  end

end
