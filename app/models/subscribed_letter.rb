class SubscribedLetter < ActiveRecord::Base
  attr_accessible :letter_id, :user_id

  belongs_to :user
  belongs_to :letter

  include ActiveModel::Dirty

  around_update :update_sidebar

   scope :threads_for_user, (lambda do |my_id| 
  		select("subscribed_letters.user_id").where(["(subscribed_letters.user_id = ?)",my_id]).group("subscribed_letters.user_id").having("COUNT(subscribed_letters.letter_id)=1")
  	end)



   def update_sidebar

   		if self.read_changed?
   			@bar = Conversation.find(:first, :conditions=>["sidebar_owner_id = ? and last_letter_id = ?",self.user_id,self.letter_id])
   			if @bar
   				if @bar.unread == true
   					@bar.unread = false 
   					@bar.save
   				end
   			end
   		end
   end

end