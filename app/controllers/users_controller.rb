class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update]
  
  def new
    @user = User.new
  end
  
  def create
    default = {'photo_filter'=>'On', 'admin'=>false}
    unless params[:user][:options].nil?
      default['photo_filter'] = params[:user][:options]['photo_filter']
    end
    params[:user][:options] = default
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = t(:account_registered)
      redirect_to root_url
    else
      render :action => :new
    end
  end
 
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      flash[:success] = t(:account_updated)
      redirect_to root_url
    else
      render :action => :edit
    end
  end
end