class User < ActiveRecord::Base
  attr_accessible :avatar, :email, :first_name, :last_name, :login_count, :oath_expires_at, :oath_token, :provider, :uid

  after_create :set_count

  has_many :subscribed_letters
  has_many :letters, :through=>:subscribed_letters

  has_many :conversations, :foreign_key => :sidebar_owner_id
  
  before_create :generate_token
  before_create :generate_username

   include AlgoliaSearch

    algoliasearch do
      attribute :first_name, :last_name, :email
    end



  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.email = auth.info.email
      user.avatar = auth.info.image
      user.oath_token = auth.credentials.token
      user.oath_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

  def set_count
  	self.login_count = 1
  	self.save!
  end


  def active_drafts
    drafts = Letter.find(:all, :conditions=>["mailed = ? and author_id = ? and content != ? and content is not null",false,self.id,""])
  end




  protected

  def generate_token
    self.auto_login_token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless User.exists?(auto_login_token: random_token)
    end
  end

  def generate_username
    i = 0
    self.username = loop do
      if i == 0
        temp_username = "#{self.first_name}.#{self.last_name}".downcase
      else
        temp_username = "#{self.first_name}.#{self.last_name}.#{i}".downcase
      end
      i = i + 1
      break temp_username unless User.exists?(username: temp_username)
    end
  end


end