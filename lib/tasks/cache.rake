namespace :cache_expire do
  desc "Parse the Archive Server's index of files, creating 'Download' objects, each object is reverified everytime the script is run."
  task :update => :environment do
    ActionController::Base.new.expire_fragment('application_who_is_playing')
    ActionController::Base.new.expire_fragment('alternative_who_is_playing')
  end
end