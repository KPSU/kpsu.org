  class UsersController < ApplicationController
  
  layout 'alternative'
  before_filter :require_user, :except => ['index', 'show', 'blogs', 'posts']
  before_filter :no_listener, :except => ['listener', 'listener_edit', 'listener_update', 'index', 'show', 'blogs']
  before_filter :is_staff, :only => ['new', 'create', 'destroy']
  before_filter :has_profile_filled_out, :except => ['edit', 'update', 'dashboard']
  before_filter :increment_visit, :only => ['show']

  respond_to :html, :json, :xml
  
  def index

    # There are four supporting methods for this action:
    
    # => #get_users_by_genre #get_djs #get_top_djs #paginate_index

    # They have been split out of this method (index) to make it more readable.
    # Each of them is undernearth 'private' towards the bottom of this
    # controller. There is little to no reason to move them from the
    # private section. 
  
    @most_popular, @most_popular_this_week, @most_downlads = get_top_djs
    
    # Lookup DJs by Genre, DJ, or nothing.
    # The only difference between DJs and the nothing option,
    # is that DJs makes sure they have a show on the schedule.
      
    if params[:genre]
      @genre, @users = get_users_by_genre(params[:genre])
    elsif params[:dj]
      @users = get_djs
    else
      @users = User.includes([:programs, :downloads]).where('users.listener != ?', 'true')
    end
  
    # Now setup pagination, and paginate
    # returning back the paginated @users

    params[:page] ? @page = params[:page] : @page = 1
    @users = paginate_index(@page, 30, @users)
    
    # Setup error notice

    if @users.size == 0 || nil
        flash[:notice] = "No users were found matching that criteria"
    end  
    
    # Render the page

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end

  end

  # GET /users/1
  # GET /users/1.xml
  def feed
    @status = Status.new
    if params[:page]
      @page = params[:page]
    else
      @page = 1
    end
    if params[:announcement]
      @url_param = "?announcement=true"
      @c = Status.where(:announcement => true)
      @f = []
      @c.each do |c| 
        @fi = FeedItem.where('status_id = ? AND feed_id = ?', "#{c.id}", "#{current_user.feed.id}")
          if @fi.size > 0
            @fi.each do |f|
              @f << f.id
            end
          end
      end
      @feed = FeedItem.find(@f).paginate(:page => @page, :per_page => 5)
    elsif params[:comments]
      @url_param = "?comments=true"
      @c = Comment.where(:profile_id => current_user.id)
      @f = []
      @c.each do |c| 
        @fi = FeedItem.where('comment_id = ?', "#{c.id}")
          if @fi.size > 0
            @fi.each do |f|
              @f << f.id
            end
          end
      end
      @feed = FeedItem.find(@f).paginate(:page => @page, :per_page => 5)
    else
      if current_user.feed
        @feed = current_user.feed.feed_items.order("created_at DESC").paginate(:page => @page, :per_page => 5 )
      end
        
    end
    
    respond_to do |format|
      format.html { render :partial => "feed" }
      format.js { render :partial => "feed" }
    end
  end
  
  def show
    @user = User.find(params[:id], :include => [:playlists])
    @page = params[:page]
    if @user != nil
      @blogs = Post.where(:user_id => @user.id).order("created_at DESC").paginate(:page => @page, :per_page => 4)
      unless @user == nil
      respond_to do |format|
          format.html # show.html.erb
          format.xml  { render :xml => @user }
      end
      else
        redirect_to(users_path)
      end
    else
      four_oh_four_error
    end
  end
  
  def directory
    @users = User.includes(:programs).where("listener = ? AND last_login_at >= ?", false, Time.zone.now-6.months)
    respond_to do |format|
      format.js { render :partial => "directory" }
    end
  end

  def blogs
    @user = User.find(params[:id])
    @page = params[:page]
    @blogs = Post.where(:user_id => @user.id).order("created_at DESC").paginate(:page => @page, :per_page => 4)
    respond_to do |format|
      format.js { render :partial => "posts" }
    end
  end
  
  def volunteer_hours
    @user = current_user
    @vh2 = VolunteerHour.where(:user_id => current_user.id, :approved => false).order("created_at DESC")
    if params[:volunteer_hour]
      @v_date = "#{params[:date][:month]}/#{params[:date][:day]}/#{params[:date][:year]} 0:00:00"
      @vh = VolunteerHour.new()
      @vh.hours = params[:volunteer_hour][:hours]
      @vh.description = params[:volunteer_hour][:description]
      @vh.v_date = Time.parse(@v_date)
      @vh.user_id = @user.id
      @vh.approved = false
      if @vh.save
        respond_to do |format|
          format.js { render :partial => "volunteer_saved.js" }
        end
      else
        respond_to do |format|
          format.js { render :partial => "volunteer_error.js" }
        end
      end
    else
      @m = Time.zone.now.month
      @dinm = days_in_month(@m)
      @user_hours = @user.monthly_hours(@m, @dinm)
      @vh = VolunteerHour.new
      respond_to do |format|
        format.html
        format.js { render :partial => "volunteer_hours" }
      end
    end
  end
  
  def dashboard
    @status = Status.new
    respond_to do |format|
      format.html
    end
  end
  
  def listener
    
  end
  
  def listener_edit
    @title = "Edit Profile"
    if current_user.id == params[:id].to_i || current_user.staff
      @user = User.find(params[:id])
    else
      redirect_to(listener_edit_path(current_user))
    end
    
    respond_to do |format|
      format.html
      format.js { render :partial => "listener_edit" }
    end
  end
  
  def listener_update
    @user = User.find(params[:id])
    # Just trying to prevent some dubious behavior.
    if params[:user][:dj_name]
      params[:user][:dj_name] = nil
    end
    # Checking to make sure listener is set to true
    if @user.listener == false
      @user.listener = true
    end
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.js { render :partial => "listener.saved.js" }
      else
        format.js { render :partial => "listener.error.js" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy_download
    @download = Download.find(params[:id])
    if @download.user == current_user
      @download.user = nil
      @download.program = nil
      if @download.save
        @user = current_user
        respond_to do |format|
          format.js { render :partial => "my_downloads" }
        end
      else
        respond_to do |format|
          format.js { render :partial => "own_download_error.js.erb" }
        end
      end
    end
  end
  
  def own_download
    @download = Download.find(params[:id])
    if params[:program_id]
      @program = Program.find(params[:program_id])
    else
      @program = current_user.programs.first
    end
    Rails.logger.info @download.id
    if @download
      @download.user = current_user
      @download.program = @program   
      if @download.save
        @user = current_user
        respond_to do |format|
          format.js { render :partial => "my_downloads" }
        end
      else
        respond_to do |format|
          format.js { render :partial => "own_download_error.js.erb" }
        end
      end
    end
  end
  
  def downloads
   @user = User.find(params[:id])
   @orphans = Download.find_all_by_user_id(nil)
   @latest = Download.find(:all, :order => 'created_at DESC', :limit => 24)
   respond_to do |format|
     format.js {render :partial => "downloads"}
   end
  end
  
  def stats
    respond_to do |format|
      format.js {render :partial => "stats" }
    end
  end
  
  # GET /users/new
  # GET /users/new.xml
  def new
    @title = "Create New User"
    if current_user && current_user.staff
    @user = User.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.js { render :partial => "form" }
      format.xml  { render :xml => @user }
    end
    else
      redirect_to(root_url)
    end
  end

  # GET /users/1/edit
  def edit
    @lookup = User.find(params[:id])
    @title = "Edit Profile" 
    if current_user == @lookup || current_user.staff
      @user = User.find(params[:id])
    end
    respond_to do |format|
      format.html
      format.js { render :partial => "form" }
    end
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])
    
    # Let user know what their password is,
    # ideally I'd generate the user a random password on creation
    # and let them change it on first log in, but this is neither ideal
    # or too good considering the varying degrees of computer skill amongst
    # kpsu users.
    
    @password = params[:password]
    @user.listener = false
    @user.chatroom_id = ActiveSupport::SecureRandom::hex(16)
   
    respond_to do |format|  
      if @user.save
        UserMailer.welcome_email(@user, @password).deliver
        format.html { redirect_to(@user, :notice => 'User was successfully created.') }
        format.js { render :partial => "saved_new_user.js"}
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end


  def update
    @user = User.find(params[:id])
    
    @phone = params[:user][:phone].gsub(/[^0-9]/, "")
    @user.email = params[:user][:email]
    
    #this checks to make sure it is not updating the password if no parameters have been entered

    if params[:user][:password]
      @user.password = params[:user][:password]
      @user.password_confirmation = params[:user][:password_confirmation]
    end
    
    @user.f_name = params[:user][:f_name]
    @user.l_name = params[:user][:l_name]
    if params[:user][:avatar]
      @user.avatar = params[:user][:avatar]
    end
    @user.phone = @phone.to_i
    @user.influences = params[:user][:influences]
    @user.about = params[:user][:about]
    @user.homepage = params[:user][:homepage]
    @user.age = params[:user][:age]
    @user.dj_name = params[:user][:dj_name]
    
    respond_to do |format|
      if @user.save
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.js { render :partial => "saved.js" }
      else
        format.html { render :action => "edit" }
        format.js { render :partial => "error.js" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end

  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
  
  private

  def get_users_by_genre(genre)
    @genre = Genre.includes(:programs => [:user => [:downloads]]).find(params[:genre])
    @users = @genre.programs.collect{|program| if program.event then program.user end}
    return @genre, @users
  end

  def get_djs
    @users = Event.includes(:program => [:user => [:downloads]]).collect do |e|
      unless RAILS_ENV == "development"
        if e.program.user.avatar.exists? && e.program.user.downloads.size >= 1
          e.program.user 
        end
      else
        if !e.program.user.avatar.exists? && e.program.user.downloads.size >= 1
          e.program.user 
        end
      end
    end.compact
  end


  def get_top_djs
  
    @month, @week, @users = Date.today-1.month, Date.today-1.week, User.all
  
    @most_popular = @users.sort{|x,y| x.profile_views <=> y.profile_views }
    @most_downloads = @users.sort{|x,y| x.total_downloads_within(@month) <=> y.total_downloads_within(@month) }
    @most_popular_week = @users.sort{|x,y| x.profile_views_within(@week) <=> y.profile_views_within(@week) }
  
    return @most_popular, @most_downloads, @most_popular_this_week
  
  end

  def paginate_index(page, per_page, users_array)
    users = WillPaginate::Collection.create(page, per_page, users_array.size) do |pager|
        us = users_array.paginate(:page => page.to_i, :per_page => per_page.to_i)
        pager.replace(us)
    end 
  end
  
  def increment_visit
      
      if @u
        @v = View.new
        @v.viewable = @u
        @v.user_agent = request.user_agent
        @v.save
      end
  end
  
end
