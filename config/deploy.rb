set :application, "kpsu.org"
set :user, "seve"
set :scm, :git
set :deploy_to, "/var/www/#{application}"
set :repository, "ssh://seve@kpsu.org:6666/var/git/#{application.gsub('.org','')}"
set :port, 6666

# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, application                          # Your HTTP server, Apache/etc
role :app, application
role :db,  application, :primary => true # This is where Rails migrations will run

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts
default_run_options[:pty] = true 
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "cd /var/www/kpsu.org/current; /opt/ruby-1.9.3/bin/bundle install"
    run "#{sudo} /etc/init.d/thin restart"
  end
end