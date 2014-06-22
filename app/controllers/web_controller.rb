class WebController < ApplicationController
  
   before_filter :authenticate, :except => [:home]

  def home

  	if current_user
  		@letters = Letter.received_or_sent(current_user.id).order_by_date
  	end
  	
  end


  def random

  end

 
end
