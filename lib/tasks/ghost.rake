namespace :ghost do
  desc "Parse the Archive Server's index of files, creating 'Download' objects, each object is reverified everytime the script is run."
  task :update => :environment do
    #This will create a ghost download while the show is going on.
    #Will allow the playlist's download drop-down to list it as a possible download for selection.



    #Will (Let's say we're doing this at 5:00pm)
    #1)  Create a Download for the 5:00-6:00pm slot which has a title reflecting 5:00PM
    #2)  archive:update will instead of creating a new Download, will update the attributes of the Download, at 6:05pm

#1.  Create a variable with the current hour
#2.  Parse the Event table for any even on this hour on this day
#3.  Create a download with no URL with title "current" and the right program_id
#4.  This will operate 1 hr and 5 minutes ahead of the archive:update, which'll fix its URL and title.

    
    @current_pdt_time = Time.now.utc + Time.zone_offset("PDT")
    @current_hour = "#{@current_pdt_time.hour}:00"
    _e = Event.find(:first, :conditions => ['starts_at = ? and day_i = ?', @current_hour, @current_pdt_time.to_date.cwday])
    if _e == nil
      @hh = "#{@current_pdt_time.hour-1}:00"
      @maybe = Event.find(:first, :conditions => ['starts_at = ? and day_i = ?', @hh, @current_pdt_time.to_date.cwday])
      if @maybe
        if @maybe.ends_at - @maybe.starts_at > 3601
          _e = @maybe
        end
      end
    end

    if _e
      Download.create(:program_id => _e.program_id, :title => "Current Show")
    end
  end
end