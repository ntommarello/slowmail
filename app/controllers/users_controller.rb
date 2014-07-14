class UsersController < ApplicationController

 before_filter :authenticate






  def settings
  end

  def index
  end

  def my_drafts

  	@drafts = current_user.active_drafts

  	if @drafts.length == 1
  		redirect_to @drafts[0].tag
  	end

  end


end
