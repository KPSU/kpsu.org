
# To run this on the KPSU server, using the :create_intitial_roles task
# /opt/ruby-enterprise-1.8.7-2010.02/bin/rake roles:create_initial_roles RAILS_ENV=production
# this file is for seeding, and creating initial roles
# you don't need to mess with this unless you're creating a bunch of new roles
# and want to have a record of it

# Created: 4/25/2011

namespace :roles do
  desc "Create initial KPSU operational positions e.g. staff and genre directors"
  task :create_initial_roles => :environment do
    
    # Setup initial role titles
    # an array is easy enough
    
    @roles = ["web director", "manager", "music director", 
              "assistant music director", "promotions director", "assitant promtions director", 
              "mulimedia director", "development director", "assistant development director",
              "production director", "technical director", "programming/volunteer director", 
              "electronic music director", "jazz music director", "loud rock music director", 
              "world music director", "hip-hop music director", "vinyl music director", 
              "experimenal music director"]
              
    
    # Create roles
    
    @roles.each do |role|
      @r = Role.new
      @r.title = role
      @r.save
    end
    
    # Now assign roles to users.
    # At this time I only know who to
    # assign staff roles, so the genre director roles
    # are created and not assigned
    
    # A list of ids in the order of the roles above
    # if you're messing with this, the way to get the ids
    # is easy, just look them up by hand
    
    @user_ids = [1, 44, 82, 68, 20, 99, 83, 74, 50, 77, 62, 63, 44]
    
    # @user_roles:
    # Combine the two arrays into a hash for assigning
    # users to the newly created roles
    
    @user_roles = Hash[*@roles.zip(@user_ids).flatten]  
    
    # This is the action to create them
    # standard ruby syntax for |k,v|
    # k: role
    # v: user id
    
    @user_roles.each do |k,v|
      
      if v != nil
        @role = Role.find_by_title(k)
        @user = User.find(v)
        @role.user = @user
        @role.save
        puts "#{@role.title} assigned to: #{@role.user.dj_name}"
      else
        puts "No one assigned to #{@role.title}"
      end
      
    end
    
    # Added this in to set listener status to false for all the current users
    
    @users = User.all
    @users.each {|u| u.listener = false && u.save }
    
  end
  
  task :create_initial_abilities => :environment do
    
    @web = ["web director"]
    
    @abilities = {
                  1 => {"title" => "Create User", "url" => "users/new"},
                  2 => {"title" => "Create Program", "url" => "programs/new"},
                  3 => {"title" => "Manage Programs", "url" => "programs" },
                  5 => {"title" => "Underwriting", "url" => "underwriting"},
                  6 => {"title" => "Questions and Answers About KPSU", "url" => "contents/view/6"},
                  7 => {"title" => "Why Should I Underwrite KPSU?", "url" => "contents/view/7"},
                  8 => {"title" => "Rates and Guidelines", "url" => "contents/view/8"},
                  9 => {"title" => "Some Final Words...", "url" => "contents/view/9"},
                  10 => {"title" => "Donate", "url" => "donate"}
                }
    
    @abilities.each do |ability|
      @a = Ability.where(:title => ability[1]["title"]).first
      if @a == nil
        a = Ability.new(:title => ability[1]["title"], :url => ability[1]["url"])
        a.save
        puts a
      else
        a = @a
      end
      @web.each do |role|
        @role = Role.where(:title => role).first
        if a.roles
              a.roles << @role
              puts "#{a.title} assigned to #{@role.title}"
        else
          a.roles << @role
          puts "#{a.title} assigned to #{@role.title}"
        end
      end
    end
    
    
      
    
    @manage_users = ["manager", "programming/volunteer director"]
    @manage_u_abilities = {
                  1 => {"title" => "Create User", "url" => "users/new"},
                  2 => {"title" => "Create Program", "url" => "programs/new"},
                  3 => {"title" => "Manage Programs", "url" => "programs" }
                }
    
    
    @manage_u_abilities.each do |ability|
      @a = Ability.where(:title => ability[1]["title"]).first
      if @a == nil
        a = Ability.new(:title => ability[1]["title"], :url => ability[1]["url"])
        a.save
        puts a
      else
        a = @a
      end
      @manage_users.each do |role|
        @role = Role.where(:title => role).first
        if a.roles
              a.roles << @role
              puts "#{a.title} assigned to #{@role.title}"
        else
          a.roles << @role
          puts "#{a.title} assigned to #{@role.title}"
        end
      end
    end
    
    
    @development_users = ["development director", "assistant development director"]
    @development_abilities = {
                    5 => {"title" => "Underwriting", "url" => "underwriting"},
                    6 => {"title" => "Questions and Answers About KPSU", "url" => "contents/view/6"},
                    7 => {"title" => "Why Should I Underwrite KPSU?", "url" => "contents/view/7"},
                    8 => {"title" => "Rates and Guidelines", "url" => "contents/view/8"},
                    9 => {"title" => "Some Final Words...", "url" => "contents/view/9"},
                    10 => {"title" => "Donate", "url" => "donate"}
                  }


    @development_abilities.each do |ability|
      @a = Ability.where(:title => ability[1]["title"]).first
      if @a == nil
        a = Ability.new(:title => ability[1]["title"], :url => ability[1]["url"])
        a.save
      else
        a = @a
      end
      @development_users.each do |role|
        @role = Role.where(:title => role).first
        if a.roles
          a.roles << @role
          puts "#{a.title} assigned to #{@role.title}"
        else
          a.roles << @role
          puts "#{a.title} assigned to #{@role.title}"
        end
      end
    end
  
  end
  
  task :add_volunteer_hours => :environment do
    @manage_users = ["manager", "programming/volunteer director", "web director"]
    @manage_abilities = {
                    5 => {"title" => "Volunteer Management", "url" => "volunteer_hours" }
                  }
   @manage_abilities.each do |ability|
     @a = Ability.where(:title => ability[1]["title"]).first
     if @a == nil
       a = Ability.new(:title => ability[1]["title"], :url => ability[1]["url"])
       a.ajax = true
       a.save
       puts a
     else
       a = @a
     end
     @manage_users.each do |role|
       @role = Role.where(:title => role).first
       if a.roles
             a.roles << @role
             puts "#{a.title} assigned to #{@role.title}"
       else
         a.roles << @role
         puts "#{a.title} assigned to #{@role.title}"
       end
     end
   end
  end
  
  task :add_version_three_udpates => :environment do
    @manage_users = ["manager", "programming director", "volunteer director", "web director"]
    @manage_abilities = {
                    1 => {"title" => "Events", "url" => "happenings" },
                    2 => {"title" => "Strikes", "url" => "strikes" }
                  }
   @manage_abilities.each do |ability|
     @a = Ability.where(:title => ability[1]["title"]).first
     if @a == nil
       a = Ability.new(:title => ability[1]["title"], :url => ability[1]["url"])
       a.ajax = true
       a.save
       puts a
     else
       a = @a
     end
     @manage_users.each do |role|
       @role = Role.where(:title => role).first
       if a.roles
             a.roles << @role
             puts "#{a.title} assigned to #{@role.title}"
       else
         a.roles << @role
         puts "#{a.title} assigned to #{@role.title}"
       end
     end
   end
   
  @promotions_users = ["promotions director", "assistant promotions director"]
  @promotions_abilities = {
                   1 => {"title" => "Events", "url" => "happenings" }
                 }
  @promotions_abilities.each do |ability|
     @a = Ability.where(:title => ability[1]["title"]).first
     if @a == nil
       a = Ability.new(:title => ability[1]["title"], :url => ability[1]["url"])
       a.ajax = true
       a.save
       puts a
     else
       a = @a
     end
     @promotions_users.each do |role|
       @role = Role.where(:title => role).first
       if a.roles
             a.roles << @role
             puts "#{a.title} assigned to #{@role.title}"
       else
         a.roles << @role
         puts "#{a.title} assigned to #{@role.title}"
       end
     end
   end
   
   @music_users = ["music director", "manager", "programming director", "web director"]
   @music_abilities = {
                    1 => {"title" => "Featured Artists", "url" => "site/featured_artists" }
                  }
   @music_abilities.each do |ability|
     @a = Ability.where(:title => ability[1]["title"]).first
     if @a == nil
       a = Ability.new(:title => ability[1]["title"], :url => ability[1]["url"])
       a.ajax = true
       a.save
       puts a
     else
       a = @a
     end
     @music_users.each do |role|
       @role = Role.where(:title => role).first
       if a.roles
             a.roles << @role
             puts "#{a.title} assigned to #{@role.title}"
       else
         a.roles << @role
         puts "#{a.title} assigned to #{@role.title}"
       end
     end
   end
   
  end
  
end