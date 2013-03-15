class ProgramsController < ApplicationController
  layout 'alternative'
  before_filter :require_user, :only => ['new', 'edit', 'destroy', 'update', 'create', 'index']
  before_filter :no_listener, :only => ['new', 'edit', 'destroy', 'update', 'create', 'index']
  before_filter :is_staff, :only => ['new', 'create', 'destroy', 'index']
  before_filter :has_profile_filled_out
  before_filter :increment_visit, :only => ['show']

  
  # GET /programs
  # GET /programs.xml
  def index
    @programs = Program.where('user_id IS NOT ?', nil).includes([:user]).order('created_at DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @programs }
    end
  end
  
  def public_index
    @programs = Program.joins(:event).where("program_id != ?", "nil").includes(:user).order('created_at ASC').paginate(:page => params[:page], :per_page => 10)

    respond_to do |format|
      format.html
    end
  end
  
  def download
    @download = Download.find(params[:id])
    if @download.count == nil
      @download.count = 0
      @download.count += 1
    else
      @download.count += 1
    end
    @download.save
    redirect_to("#{@download.url}")
  end
  
  # GET /programs/1
  # GET /programs/1.xml
  def show
    @program = Program.find(params[:id])
    if @program != nil
      @sidebar_downloads = Download.where("user_id = ? AND title IS NOT ? OR program_id > ?", @program.user, nil, 0).includes(:program, :user).order("created_at DESC").limit(10)
      
      #@downloads = @program.downloads.sort! {|x,y| x.title.to_i <=> y.title.to_i }
      @playlists_with_downloads = Array.new
      @playlists_all = @program.playlists
      @playlists_all.each do |p_a|
        if p_a.download_id != nil
          @playlists_with_downloads.push p_a
        end
      end
      @downloads = Array.new
      @playlists_with_downloads.each do |p_w_d|
        @d = Download.find(p_w_d.download_id)
        @downloads.push @d
      end

      #OK, so I've replaced the old "Downloads" array with a new one.  It first pulls all playlists that have download ids
      #Then it creates a downloads array based off those playlists.  Simple enough.

      @playlists = @program.playlists.order("created_at DESC").paginate(:page => params[:page], :per_page => 5)
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @program }
      end
    else
      four_oh_four_error
    end
  end

  # GET /programs/new
  # GET /programs/new.xml
  def new
    @users = User.where(:listener => false)
    @program = Program.new
    @genres = Genre.all
    respond_to do |format|
      format.html # new.html.erb
      format.js { render :partial => "form" }
      format.xml  { render :xml => @program }
    end
  end

  def program_manager_edit
    @genres = Genre.all
    unless current_user.staff
      @users = User.find(:all, :conditions => ['id = ?', current_user.id])
      if current_user.programs.include?(Program.find(params[:id]))
        @program = Program.find(params[:id])
      else
        redirect_to(dashboard_path, :notice => "Whoops! Something went wrong, we've logged it and will look into it.")
      end
    else
      @users = User.all
      @program = Program.find(params[:id])
    end
    respond_to do |format|
      format.html
      format.js { render :partial => "form"}
    end
  end

  # GET /programs/1/edit
  def edit
    @genres = Genre.all
    unless current_user.staff
      @users = User.find(:all, :conditions => ['id = ?', current_user.id])
      if current_user.programs.include?(Program.find(params[:id]))
        @program = Program.find(params[:id])
      else
        redirect_to(dashboard_path, :notice => "Whoops! Something went wrong, we've logged it and will look into it.")
      end
    else
      @users = User.all
      @program = Program.find(params[:id])
    end
    respond_to do |format|
      format.html
      format.js { render :partial => "edit"}
    end
  end

  # POST /programs
  # POST /programs.xml
  def create
    @day = params[:day]
    @starts_at_h = params[:date][:starts_at_hour]
    @starts_at_m = params[:date][:starts_at_minute]
    @ends_at_h = params[:date][:ends_at_hour]
    @ends_at_m = params[:date][:ends_at_minute]
    @starts_at = "#{@starts_at_h}:#{@starts_at_m}"
    @ends_at = "#{@ends_at_h}:#{@ends_at_m}"
    @event = Event.new(:starts_at => @starts_at, :ends_at => @ends_at, :day_i => @day, :name => params[:program][:title])
    @program = Program.new(params[:program])
    @user = User.find(params[:user])
    @program.user = @user
    if @program.save
      @event.program = @program
      @event.save
      respond_to do |format|
        format.html { redirect_to(@program, :notice => 'Program was successfully created.') }
        format.xml  { render :xml => @program, :status => :created, :location => @program }
      end
    else
      respond_to do |format|

        format.html { render :action => "new" }
        format.xml  { render :xml => @program.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /programs/1
  # PUT /programs/1.xml
  def update
    @program = Program.find(params[:id])
    @program.title = params[:program][:title]
    puts @program.title.to_s
    @program.genre = Genre.find(params[:genre])
    @program.thumb = params[:program][:thumb]
    @program.description = params[:program][:description]
    if current_user.staff
      @program.user = User.find(params[:user])
    end
    @event = @program.event
    if @event == nil && current_user.staff
      @event = Event.new(:name => @program.title, :starts_at => params[:date][:starts_at_hour], :ends_at => params[:date][:ends_at_hour], :day_i => params[:day], :program => @program)
      @event.save
    end
    @day = params[:day]
    
    if current_user.staff
    if (@event.starts_at.time_of_day! != Time.parse("#{params[:date][:starts_at_hour]}:#{params[:date][:starts_at_minute]}").time_of_day!) or (@event.day_i != params[:day]) or (@event.ends_at.time_of_day! != Time.parse("#{params[:date][:ends_at_hour]}:#{params[:date][:ends_at_minute]}").time_of_day!)
      if update_schedule(@event, @day, params[:date]) == true
        respond_to do |format|
          if @program.save
            format.html { redirect_to(@program, :notice => 'Program was successfully updated.') }
            format.js { render :partial => "saved" }
            format.xml  { head :ok }
          else
            format.html { render :action => "edit" }
            format.js { render :partial => "errror" }
            format.xml  { render :xml => @program.errors, :status => :unprocessable_entity }
          end
        end
      else
        respond_to do |format|
            format.html { render :action => "edit" }
            format.xml  { render :xml => @program.errors, :status => :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        if @program.save
          format.html { redirect_to(@program, :notice => 'Program was successfully updated.') }
          format.js { render :partial => "saved" }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.js { render :partial => "error" }
          format.xml  { render :xml => @program.errors, :status => :unprocessable_entity }
        end
      end
    end
  else
    respond_to do |format|
      if @program.save
        format.html { redirect_to(@program, :notice => 'Program was successfully updated.') }
        format.js { render :partial => "saved" }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.js { render :partial => "error" }
        format.xml  { render :xml => @program.errors, :status => :unprocessable_entity }
      end
    end
  end

  end

  # DELETE /programs/1
  # DELETE /programs/1.xml
  def destroy
    @program = Program.find(params[:id])
    if @program.event
      @event = @program.event
      @event.destroy
    end
    @program.destroy
    
    respond_to do |format|
      format.html { redirect_to(programs_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def update_schedule(event, day, p)
    @starts_at = Time.parse("01/01/2000 #{p[:starts_at_hour]}:#{p[:starts_at_minute]}")
    @ends_at = Time.parse("01/01/2000 #{p[:ends_at_hour]}:#{p[:ends_at_minute]}")
    event.starts_at = @starts_at.strftime("%R")
    event.ends_at = @ends_at.strftime("%R")
    event.day_i = day
    event.name = params[:program][:title]

    if event.save
        return true
    else      
        return false
    end
  end

  def increment_visit
      @p = Program.find(params[:id])
      if @p
        @v = View.new
        @v.viewable = @p
        @v.user_agent = request.user_agent
        @v.save
      end
  end
  
  def create_program_event
  
  end
  
end
