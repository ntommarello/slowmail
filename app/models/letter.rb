class Letter < ActiveRecord::Base
    attr_accessible :anonymous, :author_id, :content, :delivery_date, :delivery_method, :email, :hearts_count, :nickname, :private, :receiver_id, :salutation, :unread, :views_count, :city

    before_destroy :update_sidebar_on_destroy 

    has_many :subscribed_letters, :dependent => :destroy
    has_many :recipients, :through=>:subscribed_letters, :source => :user
    belongs_to :author, :class_name => "User"

    scope :order_by_date, :order => "mailed_at desc"
    scope :not_delivered, where(delivered: [false, nil])
    scope :delivered, :conditions=>["delivered = ?",true]
    scope :time_for_delivery, :conditions=>["mailed = ? and delivery_date < ?",true,Time.now]

    scope :draft_for, (lambda do |current_user,tag| 
      where(["mailed = ? and author_id = ? and tag = ?",false,current_user.id,tag]) 
    end)

  	scope :received_or_sent, (lambda do |my_id,other_id| 
  		joins(:subscribed_letters).where(["letters.mailed = ? and to_count = 1 and ((subscribed_letters.user_id = ? and author_id = ?) or (author_id = ? and subscribed_letters.user_id = ?))",true,my_id,other_id,my_id,other_id]) 
  	end)

    scope :letters_received_or_sent_for, (lambda do |my_id| 
      joins(:subscribed_letters).where(["letters.mailed = ? and (subscribed_letters.user_id = ? or author_id = ?)",true,my_id,my_id]) 
    end)

  	scope :matching_tag, (lambda do |tag| 
  		where(["mailed = ? and tag=?",true,tag]) 
  	end)

   #after_create :update_sidebar_for_author

	def writing_partners(current_user)
	  user_avatars = self.recipients.pluck(:avatar)
		user_avatars.push(self.author.avatar)
		user_avatars.delete(current_user.avatar)
		unless current_user.id == self.author.id
			user_avatars.reverse
		end
		user_avatars
	end

  def writing_partner_names(current_user)
    user_names = self.recipients.pluck(:first_name)
    user_names.push(self.author.first_name)
    user_names.delete(current_user.first_name)
    unless current_user.id == self.author.id
      user_names.reverse
    end
    user_names.to_sentence.gsub("and","&")
  end

  def writing_partner_ids(current_user)
    user_names = self.recipients.pluck(:id)
    user_names.push(self.author.id)
    user_names.delete(current_user.id)
    user_names
  end

  def letter_url_for(current_user)
    if self.recipients.length == 1
      if self.author.id == current_user.id
        url = "/with/#{self.recipients[0].username}"
      else
        url = "/with/#{self.author.username}"
      end
    else
      url = "/with/#{self.tag}"
    end
  end

  def get_participant_ids
    participant_array = []
    participant_array.push(self.author.id.to_i)
    for user in self.recipients
      participant_array.push(user.id.to_i)
    end
    participant_array.sort!
    participant_ids = participant_array.join(",")
    participant_ids
  end


  

  def update_sidebar_for_author

    if self.recipients.count == 1
      message_count = Letter.received_or_sent(self.author_id,self.recipients[0].id).count
    else
      message_count = Letter.matching_tag(self.tag)
    end

    sidebar = Conversation.where(:sidebar_owner_id => self.author_id, :cc_user_ids => self.participant_ids).first_or_initialize

    sidebar.update_attributes(
     :last_letter_id => self.id,
     :unread => false,
     :message_count => message_count
    )
    sidebar.save

  end


  def update_sidebar_for_reader

    if self.recipients.count == 1
      message_count = Letter.received_or_sent(self.author_id,self.recipients[0].id).count
    else
      message_count = Letter.matching_tag(self.tag)
    end

    for user in self.recipients
      sidebar = Conversation.where(:sidebar_owner_id => user.id, :cc_user_ids => self.participant_ids).first_or_initialize

      sidebar.update_attributes(
        :last_letter_id => self.id,
        :unread => true,
        :message_count => message_count
      )
      sidebar.save

    end

  end

  def update_sidebar_on_destroy
      @conversations = Conversation.find(:all, :conditions=>["last_letter_id = ?",self.id])
      if @conversations.count > 0
        if self.recipients.count == 1
          @letters = Letter.received_or_sent(self.author_id,self.recipients[0].id)
        else
          @letters = Letter.matching_tag(self.tag)
        end
      end

      for sidebar in @conversations
        if @letters.count > 1
          sidebar.last_letter_id = @letters[0].id
          sidebar.save
        else
          sidebar.destroy
        end
      end

  end

  def deliver_letter
      self.delivery_date = Time.now
      self.delivered = true
      self.save!
      self.update_sidebar_for_reader
  end




end