class CommonNamesController < ApplicationController
  def create
    debugger
    if @taxon = Taxon.find_by_name(params[:taxon_name])
      common_name = CommonName.new(:name => params[:name], :taxon => @taxon, :language => current_user.language)
      if common_name.save
        @names = @taxon.common_names.all
        render :partial => "taxa/list", :layout => false
      else
        render :text => "Failure: Name did not save."
      end
    else
      render :text => "Failure: Taxon not found."
    end
  end
end