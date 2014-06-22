class ApplicationController < ActionController::Base
  #protect_from_forgery


  before_filter :increment


  private

  def current_user

    #session[:user_id] = User.find(6)

    @current_user ||= User.find(session[:user_id]) if session[:user_id]

 
    

  end
  helper_method :current_user

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

end
