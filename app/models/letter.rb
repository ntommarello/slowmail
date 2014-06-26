class Letter < ActiveRecord::Base
  attr_accessible :anonymous, :author_id, :content, :delivery_date, :delivery_method, :email, :hearts_count, :nickname, :private, :receiver_id, :salutation, :unread, :views_count, :city


    scope :order_by_date, :order => "created_at desc"

    scope :received_or_sent, (lambda do |user_id| 
  		{:conditions => ["(author_id = ?) or (receiver_id = ?)",user_id,user_id]}
	end)

end
