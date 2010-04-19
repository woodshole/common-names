class TaxaController < ApplicationController

  def index
    @taxon = Taxon.root
  end

  def show
    @taxon = Taxon.find(params[:id])
  end
end