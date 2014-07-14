class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :increment
  before_filter :check_auto_login_token
  helper_method :current_user


  private

  def current_user
    #session[:user_id] = User.find(4)
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def increment
  	if current_user
  		current_user.login_count = current_user.login_count + 1
  		current_user.save!
  	end
  end

  def authenticate
    unless current_user
      redirect_to "/"
    end
  end

  def check_auto_login_token
    if params[:auto_login_token]
      user = User.find_by_auto_login_token(params[:auto_login_token])
      if user
        session[:user_id] = user.id
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
      end
    end
  end


end