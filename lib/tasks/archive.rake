namespace :archive do
  desc "Parse the Archive Server's index of files, creating 'Download' objects, each object is reverified everytime the script is run."
  task :update => :environment do
    

    my_access_key_id = 'AKIAJMTH3VFDSZT33HFA'
    my_secret_key = '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'
    bucket_name = 'archive-complete'

    AWS.config({
      :access_key_id => my_access_key_id,
      :secret_access_key => my_secret_key
    })

    # Start a session.
    sts = AWS::STS.new()
    session = sts.new_session()
    puts "Session expires at: #{session.expires_at.to_s}"

    # get an instance of the S3 interface using the session credentials
    s3 = AWS::S3.new(session.credentials)

    # get a list of all object keys in a bucket
    bucket = s3.buckets[bucket_name].objects.collect(&:key)
    @current_pdt_time = Time.now.utc + Time.zone_offset("PDT")
    @url = "https://s3.amazonaws.com/archive-complete/"
    tracks = bucket.each do |track| 
    	if track.length > 3
    	  puts track
    	  url = "#{@url}" + "#{track}"
    	  _t = track.split(".mp3")[0].to_i
    	  download = Download.find_by_title(_t)
    	  track_time = Time.at(_t).utc
    		track_pdt = track_time + Time.zone_offset("PDT")
    		q = track_pdt
    		@h = "#{q.hour}:00"
    		download_time = track_pdt
    		@old_time = @current_pdt_time - 1.day
    		@previously_automix = false # (@old_time > download_time) # return true or false
    		_e = Event.find(:first, :conditions => ['starts_at = ? and day_i = ?', @h, q.to_date.cwday])
        if _e == nil
          @hh = "#{q.hour-1}:00"
          @maybe = Event.find(:first, :conditions => ['starts_at = ? and day_i = ?', @hh, q.to_date.cwday])
          if @maybe
            if @maybe.ends_at - @maybe.starts_at > 3601
              _e = @maybe
            end
          end

        end
        
        unless download
          puts download.to_json
          if _e && @previously_automix == false
            download = Download.new
            download.program = _e.program
            download.url = url
            download.count = 0
            download.user = _e.program.user
            download.title = _t
            if Download.find_by_title("2222222222")
              download.playlist_id = Download.find_by_title("2222222222").playlist_id
              @xxx = Download.find_by_title("2222222222")
              @xxx.delete
              @xxx.save
            end
            download.save
          elsif(!_e)
            download = Download.new
            download.program_id = 0
            download.url = url
            download.count = 0
            download.user_id = 0
            download.title = _t
            download.save
          end
        else
          if download.url != url
              download.url = url
              download.save
          end
        end
    	else 
    		nil
    	end
    end
  end
end