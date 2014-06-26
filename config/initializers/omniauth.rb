#OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '332849056869678', 'c70c491fe2e99df83b73bbacc6768f44', :scope => 'email', :display => 'popup', :image_size =>"large"
end