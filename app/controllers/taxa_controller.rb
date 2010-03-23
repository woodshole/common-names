class TaxaController < ApplicationController
  before_filter :load_taxonomy
  
  def index
    if params[:taxon]
      unless @taxon = Taxon.find_by_name(params[:taxon].capitalize)
        @taxon = Taxon.root
        flash.now[:notice] = "#{params[:rank].capitalize} #{params[:taxon].capitalize} could not be found."
      end
    else
      @taxon = Taxon.root
    end
    @rank = @taxon.rank
  end
  
  def data
    if params[:taxon_name].blank?
      @taxon = Taxon.find_by_name('UBT')
    else
      @taxon = Taxon.find_by_name(params[:taxon_name])
    end
    @names = @taxon.common_names.all
    render :partial => "list", :layout => false
  end

  def show
    @taxon = Taxon.find(params[:id])
  end

  private
    def load_taxonomy
      @taxonomy = [["Animalia", "Animalia"]]
    end
end
