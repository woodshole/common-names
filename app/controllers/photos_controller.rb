class PhotosController < ApplicationController
  def show
    begin
      @photo = Photo.preferred(params[:id])
    rescue
      @photo = nil
    end
    render :partial => 'best_photo', :layout => false
  end
  
  def create
    attributes = {:taxon => Taxon.find(params[:id]),
      :url => params[:url],
      :preferred => 1}
    @photo = Photo.create!(attributes)
    @photo.users << current_user
    @photo.only_preferred
    render :nothing => true, :layout => false
  end

end