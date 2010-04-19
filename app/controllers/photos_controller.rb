class PhotosController < ApplicationController
  @@flickr = Flickr.new(File.join(RAILS_ROOT, 'config', 'flickr.yml'))
  before_filter :require_user, :only => :create
  
  def show
    begin
      @photo = Photo.preferred(params[:id])
    rescue
      @photo = nil
    end
    render :partial => 'best_photo', :layout => false
  end

  def index
    @photos = @@flickr.photos.search(:machine_tags => machine_tag(params[:id]), :per_page => 8)
    render :partial => 'list', :layout => false
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
  
  private
  
  def machine_tag(id)
    rank_num = Taxon.find(id).rank
    name = Taxon.find(id).name
    case rank_num
      when 0
        rank = "kingdom"
      when 1
        rank = "phylum"
      when 2
        rank = "class"
      when 3
        rank = "order"
      when 4
        rank = "family"
    end
    "taxonomy:#{rank}=#{name}"
  end

end