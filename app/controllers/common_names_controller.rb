class CommonNamesController < ApplicationController
  def create
    @taxon = Taxon.find_by_name(params[:taxon_name])
    common_name = CommonName.new(:name => params[:name], :taxon => @taxon)
    common_name.save()
    @names = @taxon.common_names.all
    render :partial => "taxa/table", :layout => false
  end
end