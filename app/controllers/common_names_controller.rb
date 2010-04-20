class CommonNamesController < ApplicationController
  def show
    taxon = params[:id].blank? ? Taxon.root : Taxon.find(params[:id])
    language = current_language if current_filter
    @names = CommonName.language_filter(taxon, language)
    render :partial => "list", :layout => false
  end
  
  def create    
    language = current_language
    taxon = Taxon.find(params[:id])
    common_name = CommonName.create!(:name => params[:name], :taxon => taxon, :language => language, :user => current_user)
    @names = CommonName.language_filter(taxon, nil)
    render :partial => "list", :layout => false
  end
  
  def destroy
    if @common_name = CommonName.find(params[:id])
      @common_name.destroy
      render :json => {:status => "success"}
    else
      render :json => {:status => "failure"}
    end
  end
  
end