class WebController < ApplicationController
  
   before_filter :authenticate, :only => [:random]

  def home

  	if current_user
      @conversations = current_user.conversations.build_sidebar
      if @conversations and @conversations.count > 0 
        conversation = @conversations.first
        if conversation.letter and conversation.letter.recipients.length == 1
          if conversation.letter.author.id == current_user.id
            url = "/with/#{conversation.letter.recipients[0].username}"
          else
            url = "/with/#{conversation.letter.author.username}"
          end
        else
          if conversation.letter
            url = "/with/#{conversation.letter.tag}"
          end
        end
      end

      if url
        redirect_to url
      else
        @letters = Letter.find(:all, :conditions=>"id=4")
      end

  	else
  		@custom_body_class = "splash"
  	end
  	
  end





  def envelope

  end


  def random
    @page_title = "Random Letters"

  end

  def about
     @page_title = "About superslow.email"
  end
  def terms
     @page_title = "superslow.email Terms"
  end

  def privacy
     @page_title = "superslow.email Privacy Policy"
  end

 
end
