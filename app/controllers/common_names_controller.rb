class CommonNamesController < ApplicationController
  def show
    taxon = params[:id].blank? ? Taxon.root : Taxon.find(params[:id])
    render_list(taxon)
  end
  
  def create
    taxon = Taxon.find(params[:id])
    common_name = CommonName.create!(:name => params[:name], :taxon => taxon, :language => current_language, :user => current_user)
    render_list(taxon)
  end
  
  def destroy
    if @common_name = CommonName.find(params[:id])
      @common_name.destroy
      render :json => {:status => "success"}
    else
      render :json => {:status => "failure"}
    end
  end
  
  def render_list(taxon)
    language = current_language if current_filter
    @names = CommonName.language_filter(taxon, language)
    render :partial => "list", :layout => false
  end
  
end