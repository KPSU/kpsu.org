# Probably the most common use of this lib would be to get your most recent tracks or your top tracks. Below are some code samples.
#   user = Rockstar::User.new('jnunemaker')
# 
#   puts "#{user.username}'s Recent Tracks"
#   puts "=" * (user.username.length + 16)
#   user.recent_tracks.each { |t| puts t.name }
# 
#   puts
#   puts
# 
#   puts "#{user.username}'s Top Tracks"
#   puts "=" * (user.username.length + 13)
#   user.top_tracks.each { |t| puts "(#{t.playcount}) #{t.name}" }
#   
# Which would output something like:
#
#   jnunemaker's Recent Tracks
#   ==========================
#   Everything You Want
#   You're a God
#   Bitter Sweet Symphony [Original Version]
#   Lord I Guess I'll Never Know
#   Country Song
#   Bitter Sweet Symphony (Radio Edit)
# 
# 
#   jnunemaker's Top Tracks
#   =======================
#   (62) Probably Wouldn't Be This Way
#   (55) Not Ready To Make Nice
#   (45) Easy Silence
#   (43) Song 2
#   (40) Everybody Knows
#   (39) Before He Cheats
#   (39) Something's Gotta Give
#   (38) Hips Don't Lie (featuring Wyclef Jean)
#   (37) Unwritten
#   (37) Move Along
#   (37) Dance, Dance
#   (36) We Belong Together
#   (36) Jesus, Take the Wheel
#   (36) Black Horse and the Cherry Tree (radio version)
#   (35) Photograph
#   (35) You're Beautiful
#   (35) Walk Away
#   (34) Stickwitu
module Rockstar  
  class User < Base
    # attributes needed to initialize
    attr_reader :username, :period
    
    # profile attributes
    attr_accessor :id, :cluster, :url, :realname, :mbox_sha1sum, :registered
    attr_accessor :registered_unixtime, :age, :gender, :country, :playcount, :avatar, :realname, :images

    # neighbor attributes
    attr_accessor :match
    
    # track fans attributes
    attr_accessor :weight
    
    class << self
      def new_from_xml(xml, doc=nil)
        u        = User.new((xml).at(:name).inner_html)
        u.url    = Base.fix_url((xml).at(:url).inner_html)    if (xml).at(:url)
        
        u.images = {}
        (xml/'image').each {|image|
          u.images[image['size']] = image.inner_html if u.images[image['size']].nil?
        }
        
        u.avatar = u.images['small']
        
        u.weight = (xml).at(:weight).inner_html if (xml).at(:weight)
        u.match  = (xml).at(:match).inner_html  if (xml).at(:match)
        u.realname= (xml).at(:realname).inner_html    if (xml).at(:realname)
        u
      end
      
      def find(*args)
        options = {:include_profile => false}
        options.merge!(args.pop) if args.last.is_a?(Hash)
        users = args.flatten.inject([]) { |users, u| users << User.new(u, options); users }
        users.length == 1 ? users.pop : users
      end
    end
    
    def initialize(username, o={})
      options = {:include_profile => false, :period => 'overall'}.merge(o)
      raise ArgumentError if username.blank?
      @username = username
      @period = options[:period]
      load_profile() if options[:include_profile]
    end
    
    def current_events(format=:ics)
      warn "[DEPRECATION] `current_events` is deprecated. The current api doesn't offer ics/ical formatted data."
    end
    
    def friends_events(format=:ics)
      warn "[DEPRECATION] `friends_events` is deprecated. The current api doesn't offer ics/ical formatted data."
    end
    
    def recommended_events(format=:ics)
      warn "[DEPRECATION] `recommended_events` is deprecated. The current api doesn't offer ics/ical formatted data."
    end
    
    def load_profile
      doc                  = self.class.fetch_and_parse("user.getInfo", {:user => @username})
      @id                  = (doc).at(:id).inner_html
      @url                 = Base.fix_url((doc).at(:url).inner_html)
      @realname            = (doc).at(:realname).inner_html
      @registered          = (doc).at(:registered).inner_html
      @registered_unixtime = (doc).at(:registered)['unixtime']
      @age                 = (doc).at(:age).inner_html
      @gender              = (doc).at(:gender).inner_html
      @country             = (doc).at(:country).inner_html
      @playcount           = (doc).at(:playcount).inner_html
      
      @images = {}
      (doc/'image').each {|image|
        @images[image['size']] = image.inner_html
      }
      
      @avatar              = @images["small"]
    end
    
    def top_artists(force=false)
      get_instance("user.getTopArtists", :top_artists, :artist, {:user => @username, :period => @period}, force)
    end
    
    def top_albums(force=false)
      get_instance("user.getTopAlbums", :top_albums, :album, {:user => @username}, force)
    end
    
    def top_tracks(force=false)
      get_instance("user.getTopTracks", :top_tracks, :track, {:user => @username}, force)
    end
    
    def top_tags(force=false)
      get_instance("user.getTopTags", :top_tags, :tag, {:user => @username}, force)
    end
    
    def friends(force=false)
      get_instance("user.getFriends", :friends, :user, {:user => @username}, force)
    end
    
    def neighbours(force=false)
      get_instance("user.getNeighbours", :neighbours, :user, {:user => @username}, force)
    end
    
    def recent_tracks(force=false)
      get_instance("user.getRecentTracks", :recent_tracks, :track, {:user => @username}, force)
    end
    
    def recent_banned_tracks(force=false)
      warn "[DEPRECATION] `recent_banned_tracks` is deprecated. The current api doesn't offer this function"
      []
    end
    
    def recent_loved_tracks(force=false)
      get_instance("user.getLovedTracks", :recent_loved_tracks, :track, {:user => @username}, force)
    end
    
    def recommendations(force=false)
      warn "[DEPRECATION] `recommendations` is deprecated. Please use recommended_artists"
      []
    end

    # The session_key is returned by auth.session.key
    def recommended_artists(session_key, force=false)
      get_instance("user.getRecommendedArtists", :recommendations, :artist, {:user => @username, :sk => session_key}, force)
    end
    
    def charts(force=false)
      get_instance("user.getWeeklyChartList", :charts, :chart, {:user => @username}, force)
    end
    
    def weekly_artist_chart(from=nil, to=nil)
      doc = self.class.fetch_and_parse("user.getWeeklyArtistChart", {:user => @username, :from => from, :to => to})
      (doc/:artist).inject([]) { |elements, el| elements << Artist.new_from_xml(el); elements }
    end
    
    def weekly_album_chart(from=nil, to=nil)
      doc = self.class.fetch_and_parse("user.getWeeklyAlbumChart", {:user => @username, :from => from, :to => to})
      (doc/:album).inject([]) { |elements, el| elements << Album.new_from_xml(el); elements }
    end
    
    def weekly_track_chart(from=nil, to=nil)
      doc = self.class.fetch_and_parse("user.getWeeklyTrackChart", {:user => @username, :from => from, :to => to})
      (doc/:track).inject([]) { |elements, el| elements << Track.new_from_xml(el); elements }
    end

    # Get the recommendated events for the user, auth.session.key needed.
    def events(session_key, force = false)
      get_instance("user.getEvents", :events, :event, {:user => @username, :sk => session_key}, force)
    end

  end
end
