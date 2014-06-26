class User < ActiveRecord::Base
  attr_accessible :avatar, :email, :first_name, :last_name, :login_count, :oath_expires_at, :oath_token, :provider, :uid

  after_create :set_count
  
  before_create :generate_token


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



  protected

  def generate_token
    self.auto_login_token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless User.exists?(auto_login_token: random_token)
    end
  end


end