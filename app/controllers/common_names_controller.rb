class CommonNamesController < ApplicationController
  def create    
    language = current_user.language
    if @taxon = Taxon.find_by_name(params[:taxon_name])
      common_name = CommonName.new(:name => params[:name], :taxon => @taxon, :language => language)
      if common_name.save
        @names = @taxon.language_common_names(language)
        render :partial => "taxa/list", :layout => false; return
      else
        render :text => "Failure: Name did not save."; return
      end
    else
      render :text => "Failure: Taxon not found."; return
    end
  end
end