 OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_API_ID'], ENV['FACEBOOK_API_SECRET']
end
