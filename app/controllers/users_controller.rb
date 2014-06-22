class UsersController < ApplicationController

 before_filter :authenticate


  def save_draft
  	current_user.draft = params[:draft]
  	current_user.save!
  	render :text=>"1"
  end



  def settings
  end

  def index
  end



end
