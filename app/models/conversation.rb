class Conversation < ActiveRecord::Base
  attr_accessible :cc_user_ids, :count_to, :display_user_id, :last_letter_id, :last_status_date, :message_count, :replied, :sidebar_owner_id, :unread

  belongs_to :letter, :foreign_key => :last_letter_id

  scope :total_new_messages_for_user, (lambda do |current_user| 
  	where(["(sidebar_owner_id = ? and unread = ?)",current_user.id,true]) 
  end)


  scope :build_sidebar, :include=>[:letter,[:letter=>:recipients]], :order=>"unread desc, letters.delivery_date desc"

  def format_multiple_names(current_user)
  	user_names = self.letter.recipients.pluck(:first_name)
	user_names.push(self.letter.author.first_name)
	user_names.delete(current_user.first_name)
	unless current_user.id == self.letter.author.id
		user_names.reverse
	end
	user_names.to_sentence.gsub("and","&")
  end

  def format_multiple_avatars(current_user)
  	user_avatars = self.letter.recipients.pluck(:avatar)
	user_avatars.push(self.letter.author.avatar)
	user_avatars.delete(current_user.avatar)
	
	html = '<div class="avatar multiple_avatars">'
	if user_avatars.count == 2
		html = html + "<div class='a_left' style='background:url(#{user_avatars[0]}); background-size:44px 44px; background-position:-10px; border:1px solid #333 ' ></div>"
		html = html + "<div class='a_right' style='background:url(#{user_avatars[1]}); background-size:44px 44px; ; border:1px solid #333 ' ></div>"
	end
	if user_avatars.count == 3
		html = html + "<div class='a_left' style='background:url(#{user_avatars[0]}); background-size:44px 44px; background-position:-10px; ' ></div>"
		html = html + "<div class='a_top_right' style='background:url(#{user_avatars[1]}); background-size:22px 22px;  ' ></div>"
		html = html + "<div class='a_bottom_right' style='background:url(#{user_avatars[2]}); background-size:22px 22px; ' ></div>"
	end
	if user_avatars.count > 3
		html = html + "<div class='a_top_left' style='background:url(#{user_avatars[0]}); background-size:22px 22px;  ' ></div>"
		html = html + "<div class='a_bottom_left' style='background:url(#{user_avatars[1]}); background-size:22px 22px; ' ></div>"
		html = html + "<div class='a_top_right' style='background:url(#{user_avatars[2]}); background-size:22px 22px;  ' ></div>"
		html = html + "<div class='a_bottom_right' style='background:url(#{user_avatars[3]}); background-size:22px 22px; ' ></div>"
	end
	html = html + '</div>'

  end





		   	
		  




end