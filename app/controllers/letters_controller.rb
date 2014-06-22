class LettersController < ApplicationController

  before_filter :authenticate

  def create

  	@letter = Letter.new(params[:letter])
  	@letter.author_id = current_user.id
  	@letter.content = current_user.draft

  	@delivery_date = Time.now + 2.days
  	if params[:letter][:delivery_method]
  		if params[:letter][:delivery_method] == "Pony Express"
  			@delivery_date = Time.now + 3.days
  		elsif params[:letter][:delivery_method] == "Stagecoach"
  			@delivery_date = Time.now + 5.days
  		else
  			@delivery_date = Time.now + 10.days
  		end
  	end

  	@letter.delivery_date = @delivery_date
  	@letter.save!

  	current_user.draft = nil
  	current_user.save!

  	redirect_to "/"

  end

  def draft
  end

end
