class WebController < ApplicationController
  
   before_filter :authenticate, :only => [:random]

  def home

  	if current_user
  		@letters = Letter.received_or_sent(current_user.id).order_by_date
  	end
  	
  end


  def random

  end

  def about
  end
  def terms
  end
  def privacy
  end

 
end
