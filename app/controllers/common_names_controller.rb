class CommonNamesController < ApplicationController
  def create
    
    if params[:language]
      if language = Language.find_by_iso_code(params[:language])
        # found the language
      else
        render :text => "Failure: Language doesn't exist"
      end
    else
      language = current_user.language
    end
    
    if @taxon = Taxon.find_by_name(params[:taxon_name])
      common_name = CommonName.new(:name => params[:name], :taxon => @taxon, :language => language)
      if common_name.save
        @names = @taxon.language_common_names(language)
        render :partial => "taxa/list", :layout => false
      else
        render :text => "Failure: Name did not save."
      end
    else
      render :text => "Failure: Taxon not found."
    end
  end
end