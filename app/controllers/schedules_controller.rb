class SchedulesController < ApplicationController

  layout 'alternative'
  
  before_filter :require_user, :only => ['new', 'edit', 'destroy', 'update', 'create']
  before_filter :has_profile_filled_out
  before_filter :no_listener, :only => ['new', 'edit', 'destroy', 'update', 'create']
  
  respond_to :json, :js, :html  
  # GET /schedules
  # GET /schedules.xml
  def index
    @mon = Event.find_all_by_day_i(1, :order => 'starts_at ASC')
    @tues = Event.find_all_by_day_i(2, :order => 'starts_at ASC')
    @wed = Event.find_all_by_day_i(3, :order => 'starts_at ASC')
    @thurs = Event.find_all_by_day_i(4, :order => 'starts_at ASC')
    @fri = Event.find_all_by_day_i(5, :order => 'starts_at ASC')
    @sat = Event.find_all_by_day_i(6, :order => 'starts_at ASC')
    @sun = Event.find_all_by_day_i(7, :order => 'starts_at ASC')

    @start = Event.all(:order => 'starts_at ASC')
    @end = Event.find(:last, :order => 'starts_at DESC').ends_at.hour
    @json = []


    # below was commented out but I uncommented it in attempts to fix shows not going hidden problem.
    @json += @sun += @mon += @tues += @wed += @thurs += @fri += @sat # this was commented out
    #this wasn't commented out but I think it was the cause of the shows not going hidden
    #@json = Event.all
    @json.each do |u|
      if u.program.visible == 1 #or u.program.title == "Feelin' Groovy"
         #@json.delete_at(@json.index(u))
         @json.delete(u)
      end
    end

     @start.each do |u|
      if u.program.visible == 1
         #@start.delete_at(@start.index(u))
         @json.delete(u)
      end
    end

    @start = @start.first.starts_at.hour

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :partial => "schedules/events.json" }
      format.xml  { render :xml => @schedules }
    end
  end

  def edit
    @mon = Event.find_all_by_day_i(1, :order => 'starts_at ASC')
    @tues = Event.find_all_by_day_i(2, :order => 'starts_at ASC')
    @wed = Event.find_all_by_day_i(3, :order => 'starts_at ASC')
    @thurs = Event.find_all_by_day_i(4, :order => 'starts_at ASC')
    @fri = Event.find_all_by_day_i(5, :order => 'starts_at ASC')
    @sat = Event.find_all_by_day_i(6, :order => 'starts_at ASC')
    @sun = Event.find(:all, :order => 'starts_at ASC', :conditions => ['day_i = ?', 7])
    @start = Event.find(:first, :order => 'starts_at ASC').starts_at.hour
    @end = Event.find(:last, :order => 'starts_at DESC').ends_at.hour
    @json = []
    @json += @sun += @mon += @tues += @wed += @thurs += @fri += @sat
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :partial => "schedules/events.json" }
      format.xml  { render :xml => @schedules }
    end
  end

  def show
    @schedule = Event.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @schedule }
    end
  end

  def create
    @schedule = Schedule.new(params[:schedule])

    respond_to do |format|
      if @schedule.save
        format.html { redirect_to(@schedule, :notice => 'Schedule was successfully created.') }
        format.xml  { render :xml => @schedule, :status => :created, :location => @schedule }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @schedule.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @schedule = Event.find(params[:id])
    respond_to do |format|
      if @schedule.update_attributes(params[:schedule])
        format.html { redirect_to(@schedule, :notice => 'Schedule was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @schedule.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @schedule = Event.find(params[:id])
    @schedule.destroy

    respond_to do |format|
      format.html { redirect_to(schedules_url) }
      format.xml  { head :ok }
    end
  end
  
  def timeslot_availability
    @day = params[:day]
    @starts_at_h = params[:date][:starts_at_hour]
    @starts_at_m = params[:date][:starts_at_minute]
    @starts_at = "#{@starts_at_h}:#{@starts_at_m}"
    @ends_at = "#{@ends_at_h}:#{@ends_at_m}"
    
    @e = Event.find(:all, :conditions => ['starts_at >= ? AND ends_at <= ? AND day_i = ?', @starts_at, @ends_at, @day])
    if @e.size > 0
      respond_to do |format|
        format.json { render :partial => "schedules/timeslot_availability.json" }
      end
    else
      @success = "Time slot available!"
      respond_to do |format|
        format.json { render :text => @success, :status => :unprocessable_entity }
      end
    end
  end
  
  private
  def redirect
    if ['show', 'new'].include? action_name
      redirect_to(root_path)
    else

    end
  end
end
