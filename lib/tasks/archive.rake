namespace :archive do
  desc "Parse the Archive Server's index of files, creating 'Download' objects, each object is reverified everytime the script is run."
  task :update => :environment do
    html = []
    
    # These are being served up by the archive server in the studio
    # from it's broken-ass drupal installation. I'll fix it later.
    # hopefully by moving to amazon S3
    
    @pages = ["http://archive.kpsu.org/files/"]
    
    @pages.each do |page|
      html << open(page)
    end
    
    @i = 0
    Time.zone = 'Pacific Time (US & Canada)'
    html.each do |archive|
    @url = @pages[@i]
    doc = Hpricot.parse(archive)
      doc.search("a[@href]").each do |param|
        if param.to_s.include?(".mp3")
          f = param.to_s.split("href\=\"")[1]
          url = "#{@url}" + "#{param.to_s.split("href\=\"")[1].split("\"\>")[0]}"
          d = f.split(".mp3")
          @download = Download.find_by_title(d[0])
          q = Time.zone.at(d[0].to_i)
          @h = "#{q.hour}:00"
          @download_time = Time.zone.at(d[0].to_i)
          @old_time = Time.zone.now - 1.day
          @previously_automix = false # (@old_time > @download_time) # return true or false
          @e = Event.find(:first, :conditions => ['starts_at = ? and day_i = ?', @h, q.to_date.cwday])
          if @e == nil
            @hh = "#{q.hour-1}:00"
            @maybe = Event.find(:first, :conditions => ['starts_at = ? and day_i = ?', @hh, q.to_date.cwday])
            if @maybe
              if @maybe.ends_at - @maybe.starts_at > 3601
                @e = @maybe
              end
            end
          end

          unless @download
            if @e && @previously_automix == false
              @download = Download.new
              @download.program = @e.program
              @download.url = url
              @download.count = 0
              @download.user = @e.program.user
              @download.title = d[0].to_i
              @download.save
            elsif(!@e)
              @download = Download.new
              @download.program_id = 0
              @download.url = url
              @download.count = 0
              @download.user_id = 0
              @download.title = d[0].to_i
              @download.save
            end
          else
            if @download.url != url
                @download.url = url
                @download.save
            end
          end
        end
      end
        # DO NOT DELETE THIS!!
        # ALSO THE += is the KEY!
        @i += 1
    end
   
  end
end