require 'openid/store/filesystem'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter,  'GRpxk6zjTKk3o7wTuXiSw', 'q2yX19uuy2izSHKKcunNEMjk1BCGjnEeRg0JCCMF18'
  provider :facebook, '171509516235698', 'eb211ffe2368c53944ec420ac6fbcc97', {:client_options => {:ssl => {:ca_path => "/etc/ssl/certs"}}}
  provider :open_id,  OpenID::Store::Filesystem.new('/tmp')
end
