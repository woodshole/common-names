class PhotosController < ApplicationController
  def best
    begin
      @photo = Photo.preferred(params[:taxon])
    rescue
      @photo = nil
    end
    render :partial => 'best_photo', :layout => false
  end
  
  def create
    attributes = {:taxon => Taxon.find_by_name(params[:taxon]),
      :url => params[:url],
      :preferred => 1}
    @photo = Photo.create!(attributes)
    @photo.users << current_user
    @photo.only_preferred
    render :nothing => true, :layout => false
  end

end