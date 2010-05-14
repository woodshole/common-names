class TaxaController < ApplicationController
  def index
    @taxon = Taxon.root
  end
  
  # show dropdown options
  def show
    @taxa = Taxon.find(params[:id]).dropdown_options(params[:rank],params[:filter], current_language)
    render :layout => false
  end
  
  def stats
    @taxon = Taxon.find(params[:taxon_id])
    @languages = @taxon.get_languages_of_children
    @count = @taxon.get_number_of_children
    @percent_translated = @taxon.percent_of_children_with_common_name
    render :partial => 'language/stats', :layout => false
  end
end