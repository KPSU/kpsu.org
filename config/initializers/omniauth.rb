require 'openid/store/filesystem'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter,  Rails.application.config.twitter_consumer_key, Rails.application.config.twitter_consumer_secret
  provider :facebook, "", "", {:client_options => {:ssl => {:ca_path => "/etc/ssl/certs"}}}
  provider :open_id,  OpenID::Store::Filesystem.new('/tmp')
end
