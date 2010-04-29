class TaxaController < ApplicationController
  def index
    @taxon = Taxon.root
  end
  
  # show dropdown options
  def show
    @taxa = Taxon.find(params[:id]).dropdown_options(params[:rank],params[:filter])
    render :layout => false
  end
end