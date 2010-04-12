class TaxaController < ApplicationController
  before_filter :set_current_language
  
  def index
    @taxon = Taxon.root
  end

  def show
    @taxon = Taxon.find(params[:id])
  end

private

  def set_current_language
    @language = current_language
  end
  
end