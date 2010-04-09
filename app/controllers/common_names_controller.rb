class CommonNamesController < ApplicationController
  def show
    @taxon = params[:id].blank? ? Taxon.root : Taxon.find(params[:id])
    @names = @taxon.language_common_names(current_language)
    render :partial => "list", :layout => false
  end
  
  def create    
    language = current_user.language
    if @taxon = Taxon.find(params[:id])
      common_name = CommonName.new(:name => params[:name], :taxon => @taxon, :language => language, :user => current_user)
      if common_name.save
        @names = @taxon.language_common_names(language)
        render :partial => "list", :layout => false
      else
        render :text => 'error', :status => 500 
      end
    else
       render :text => 'error', :status => 500
    end
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