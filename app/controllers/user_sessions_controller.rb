class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy
  def new
    redirect_to root_url
  end

  def create
    # flattened the params hash wtoutrageousskuillduggery
    @user_session = UserSession.new(params)
    if @user_session.save
      flash[:success] = t(:login_successful)
      redirect_to root_url
    else
      if !performed?
        redirect_to root_url
      end
      flash[:failure] = t(:login_failed)
    end
  end
  
  def destroy
    current_user_session.destroy
    flash[:success] = t(:login_successful)
    redirect_to root_url
  end
  
end