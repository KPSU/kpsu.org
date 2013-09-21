module ApplicationHelper
  
  def clippy(text, bgcolor='#222222')
    html = <<-EOF
      <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000"
              width="110"
              height="14"
              id="clippy" >
      <param name="movie" value="/files/clippy.swf"/>
      <param name="allowScriptAccess" value="always" />
      <param name="quality" value="high" />
      <param name="scale" value="noscale" />
      <param NAME="FlashVars" value="text=#{text}">
      <param name="bgcolor" value="#{bgcolor}">
      <embed src="/files/clippy.swf"
             width="110"
             height="14"
             name="clippy"
             quality="high"
             allowScriptAccess="always"
             type="application/x-shockwave-flash"
             pluginspage="http://www.macromedia.com/go/getflashplayer"
             FlashVars="text=#{text}"
             bgcolor="#{bgcolor}"
      />
      </object>
    EOF
  end
  
  # this is for the schedule, don't change the numbers or the days unless you plan on redoing the schedule JS

  def days_of_the_week
    @days = [[ "Sunday", 7], ["Monday", 1], ["Tuesday", 2], ["Wednesday", 3], ["Thursday", 4], ["Friday", 5], ["Saturday", 6]]
    return @days
  end
  
  # mostly the same as above, again you'll need to modify the schedule heavily to remove or alter this

  def i_to_day(i)
    @days = {7 => "Sun", 1 => "Mon", 2 => "Tues", 3 => "Wed", 4 => "Thurs", 5 => "Fri", 6 => "Sat"}
    return @days[i]
  end
  
  # the current dj

  def current_dj
    @d = Time.zone.now.to_date.cwday
    @t = Time.zone.now
    @m = Time.zone.now.min
    @h = Time.zone.now.hour
    @time = Time.parse("#{@h}:#{@m}").time_of_day!
    @e = Event.find(:first, :conditions => ['starts_at <= ? and ends_at >= ? and day_i = ?', "#{@h}:#{@m}", "#{@h}:#{@m}", @d])
    if @e
      @program = Program.find(@e.program)
      @current_dj = User.find(@program.user)
    end
    return @current_dj
  end
  
  # the current program on right now

  def current_program
    @d = Time.zone.now.to_date.cwday
    @t = Time.zone.now
    @m = Time.zone.now.min
    @h = Time.zone.now.hour
    @time = Time.parse("#{@h}:#{@m}").time_of_day!
    @e = Event.find(:first, :conditions => ['starts_at <= ? and ends_at >= ? and day_i = ?', "#{@h}:#{@m}", "#{@h}:#{@m}", @d])
    if @e
      @program = Program.find(@e.program)
    end
    return @program
  end
  
  # who is currently playing

  def currently_playing
    @d = Time.zone.now.to_date.cwday
    @t = Time.zone.now
    @m = Time.zone.now.min
    @h = Time.zone.now.hour
    @time = Time.parse("#{@h}:#{@m}").time_of_day!
    @e = Event.find(:first, :conditions => ['starts_at <= ? and ends_at >= ? and day_i = ?', "#{@h}:#{@m}", "#{@h}:#{@m}", @d])
    @p_array = []
    unless @e == nil
      @p = Program.find(@e.program.id)
      @p_array.push(@p.title)
      @p_array.push(@p.id)
      @p_array.push(@p.user.dj_name)
    else
      @p_array = ""
      @p_array = "We're on Auto Pilot!"
    end
    return @p_array
  end
  
  # who is going to be played next

  def up_next
    unless Time.zone.now.hour >= 23
      @d = Time.zone.now.to_date.cwday
      @t = Time.zone.now
      @m = Time.zone.now.min
      @h = Time.zone.now.hour + 1
      @time = Time.parse("#{@h}:#{@m}").time_of_day!
      @e = Event.find(:first, :conditions => ['starts_at <= ? and ends_at >= ? and day_i = ?', "#{@h}:#{@m}", "#{@h}:#{@m}", @d])
      @p_array = []
      unless @e == nil
        @p = Program.find(@e.program.id)
        @p_array = [@p.title, @p.id, @p.user.dj_name]
      else
        @p_array = "We're on Auto Pilot!"
      end
      return @p_array
    else
      @d = Time.zone.now.to_date.cwday + 1
      @e = Event.find(:first, :conditions => ['starts_at <= ? and ends_at >= ? and day_i = ?', "#{00}:#{00}", "#{00}:#{00}", @d])
      @p_array = []
      unless @e == nil
        @p = Program.find(@e.program)
        @p_array += @p.title.to_a
        @p_array += @p.id.to_a
        @p_array += @p.user.dj_name.to_a
      else
        @p_array = ""
        @p_array = "We're on Auto Pilot!"
      end
      return @p_array
    end
  end
  
  def build_schedule(sun, mon, tues, wed, thurs, fri, sat)
    
  end

  # The following three methods are for convience
  # Get the latest popular dj

  def popular_this_week
    @u = PopularThisWeek.last.user
    return @u
  end

  # Get the latest download champ

  def download_champ
    @u = DownloadChamp.last.user
    return @u
  end

  # Get the latest top dj

  def top_dj
    #@u = TopDj.first.user
    @dl = []
    @max = []
    @z = []
    @dl = Download.last(24)
    @dl.each do |u|
      if u != nil && u.count != nil && u.count != 0
        @max << u
      end
    end
    #@z = @max.max_by(&:count)
    @z = @max.sort {|a,b| a.count <=> b.count }
    @u = @z.last.user
    return @u
  end

  def second_dj
    @dl = []
    @max = []
    @z = []
    @dl = Download.last(12)
    @dl.each do |u|
      if u != nil && u.count != nil && u.count != 0
        @max << u
      end
    end
    #@z = @max.max_by(&:count)
    @z = @max.sort {|a,b| a.count <=> b.count }
    @u = @z[@max.size - 1].user
    return @u
  end

   def third_dj
    @dl = []
    @max = []
    @z = []
    @dl = Download.last(6)
    @dl.each do |u|
      if u != nil && u.count != nil && u.count != 0
        @max << u
      end
    end
    #@z = @max.max_by(&:count)
    @z = @max.sort {|a,b| a.count <=> b.count }
    @u = @z[@max.size - 1].user
    return @u
  end
  
  # show_username
  # user (User class)
  # options (hash)
    # {:proper_name => true} -- OR -- {:dj_name => false}
  
  # ex: <%= show_username(user, {:proper_name => true}) %>
  
  # DESC: figures out if the user has a first and last name
  # or a dj_name and display it based on the order specified by the options hash (if both are available)
  # especially useful for <alt> and <title> tags in the HTML.

  def show_username(user, options={})
    @proper_name = nil
    @handle = nil
    if user.f_name && user.l_name
      @proper_name = "#{user.f_name} #{user.l_name}"
    end 

    if user.dj_name
      @handle = "#{user.dj_name}"
    end

    if options[:proper_name] && @proper_name
      return @proper_name
    elsif options[:proper_name] && @handle
      return @handle
    elsif options[:handle] && @handle
      return @handle
    elsif options[:handle] && @proper_name
      return @proper_name
    else
      return "No Name"
    end
  end

  # I'm not sure what this does, capitalizes genres for <select> ?

  def genres
    a = []
    Genre.all.each {|e| a << [ e.title.capitalize, e.id ]}
    return a
  end
  
  # gets the number of days in a month
  # returns integer

  def days_in_month(month)
    (Date.new(Time.now.year,12,31).to_date<<(12-month)).day
  end
  
  # shuffles an array
  # you can probably use: #sample (method)
  # if you're trying to randomize an active record collection

  def shuffle!
    size.downto(1) { |n| push delete_at(rand(n)) }
    self
  end
  
  # generates a random background color class

  def random_color
    @color = ["blue", "green", "magenta", "purple", "yellow", "orange", "red"].shuffle[0]
    return @color
  end
  
  # generates a random text color class

  def random_text_color
    @color = ["blue-text", "green-text", "magenta-text", "purple-text", "yellow-text", "orange-text", "red-text"].shuffle[0]
    return @color
  end
  
end
