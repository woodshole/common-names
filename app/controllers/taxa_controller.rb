class TaxaController < ApplicationController
  def index
    @taxon = Taxon.root
  end
  
  # show dropdown options
  def show
    taxon = Taxon.find(params[:id])
    @taxa = taxon.dropdown_options(params[:filter], current_language)
    render :layout => false
  end
  
  def stats
    @taxon = Taxon.find(params[:taxon_id])
    @language_coverage = @taxon.get_language_coverage
    @count = @taxon.get_number_of_children
    render :partial => 'language/stats', :layout => false, :collection => @language_coverage
  end
end