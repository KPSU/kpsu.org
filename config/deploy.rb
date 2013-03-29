set :application, "kpsu.org"
set :user, "mike"
set :scm, :git
set :scm_verbose, true
set :deploy_to, "/var/www/kpsu.org"
set :repository, "ssh://mike@kpsu.org:6666/var/git/kpsu.org"
set :port, 6666
set :ssh_options, {:forward_agent => true}
set :branch, "master"
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
    #run "cd /var/www/kpsu.org/current; #{sudo} /opt/ruby-1.9.3/bin/bundle install"
    #run "#{sudo} /etc/init.d/thin restart"
    #EDIT 1: the above was the stuff commented out, which worked well for a very long time.  Now I notice,
    #on the server, that the old code would not work and is what the attempted cap deploy fails at.
    #assuming the new, non-commented-out code will work but is something we should investigate if
    #there is a surplus of time and interest.
    #EDIT 2: Commented out the 'bundle install' attempt altogether, which I see as unnecessary for now.
    	#run "cd /var/www/kpsu.org/current; #{sudo} bundle install"  
        #run "#{sudo} thin restart --all /etc/thin"
    #EDIT 3:  Here is the current iteration with an explanation below
    #*Fixed; ignore the two lines below
    #This SHOULD stop all 5 thin servers, but fails with:
    #"Can't stop process, no PID found in tmp/pids/thin.pid"
    #This succeeds at starting 5 thin servers, which runs the site at a speed I like.
    #THis can stay unless a better opportunity arises.
    run "cd /var/www/kpsu.org/current && touch tmp/restart.txt"
    run "curl -H \"x-api-key:\" -d \"deployment[application_id]=301521\" -d \"deployment[host]=kpsu.org\" -d \"deployment[user]=#{user}\"  https://rpm.newrelic.com/deployments.xml"
  end

end