class PhotosController < ApplicationController
  
  def show
    begin
      @photo = Taxon.find(params[:id]).preferred_photo
    rescue
      @photo = nil
    end
    render :partial => 'best_photo', :layout => false
  end

  def index
    #class variables get reloaded on each request, this doesn't help much either though.
    page = params[:page] || 1
    @photos = Photo.flickr.photos.search(:machine_tags => Taxon.find(params[:id]).machine_tag, :per_page => 8, :page => page)
    render :partial => 'list', :layout => false
  end
  
  def create
    # need a different callback than require_user
    unless current_user.nil?
      attributes = {:taxon => Taxon.find(params[:id]),
        :url => params[:url],
        :preferred => 1}
      @photo = Photo.create!(attributes)
      @photo.users << current_user
      @photo.only_preferred
    end
    show
  end

end