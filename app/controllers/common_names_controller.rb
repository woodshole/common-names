class CommonNamesController < ApplicationController
  before_filter :require_user, :only => :create
  
  def show
    taxon = Taxon.find(params[:id]) || Taxon.root
    @names = taxon.common_names_list(params[:filter], current_language)
    render :partial => "list", :layout => false
  end
  
  def create
    taxon = Taxon.find(params[:id])
    common_name = CommonName.create!(:name => params[:name], :taxon => taxon, :language => Language.find(params[:language]), :user => current_user)
    render :nothing => true, :layout => false
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