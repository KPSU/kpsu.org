# Below is an example of how to get the top fans for a track.
# 
#   track = Rockstar::Track.new('Carrie Underwood', 'Before He Cheats')
#   puts 'Fans'
#   puts "=" * 4
#   track.fans.each { |u| puts u.username }
#   
# Which would output something like:
# 
#   track = Rockstar::Track.new('Carrie Underwood', 'Before He Cheats')
#   puts 'Fans'
#   puts "=" * 4
#   track.fans.each { |u| puts "(#{u.weight}) #{u.username}" }
# 
#   Fans
#   ====
#   (69163) PimpinRose
#   (7225) selene204
#   (7000) CelestiaLegends
#   (6817) muehllr
#   (5387) Mudley
#   (5368) ilovejohnny1984
#   (5232) MeganIAD
#   (5132) Veric
#   (5097) aeVnar
#   (3390) kristaaan
#   (3239) kelseaowns
#   (2780) syndication
#   (2735) mkumm
#   (2706) Kimmybeebee
#   (2648) skorpcroze
#   (2549) mistergreg
#   (2449) mlmjcace
#   (2302) tiNEey
#   (2169) ajsbabiegirl

class BadSessionError < StandardError; end
class UnavailableError < StandardError; end
class RequestFailedError < StandardError; end


module Rockstar
  class Track < Base
    attr_accessor :artist, :artist_mbid, :name, :mbid, :playcount, :rank, :url
    attr_accessor :summary, :content, :streamable, :album, :album_mbid, :date, :date_uts, :duration
    
    # only seems to be used on top tracks for tag
    attr_accessor :count, :thumbnail, :image, :images
    
    # for weekly top tracks
    attr_accessor :chartposition
    
    class << self
      def new_from_xml(xml, doc=nil)
        artist          = (xml).at(:artist)['name']               if (xml).at(:artist) && !(xml).at(:artist)['name'].nil?
        artist          = (xml).at(:artist).at(:name).inner_html  if artist.nil? && (xml).at(:artist) && (xml).at(:artist).at(:name)
        artist          = (xml).at(:artist).inner_html            if artist.nil? && (xml).at(:artist)
        artist          = doc.root['artist']                      if artist.nil? && doc.root['artist']
        name            = (xml).at(:name).inner_html              if (xml).at(:name)
        name            = xml['name']                             if name.nil? && xml['name']

        track = Track.new(artist, name)
        track.load_info(xml)
        track
      end

      def love(artist, track, session_key)
        doc = Hpricot::XML(Track.connection.post("track.love", true, {:track => track, :artist => artist, :sk => session_key}))
        doc.at("lfm")["status"]
      end

      # Scrobble a song
      #
      # Possible parameters:
      #    session_key (required) : the session key you got during authentification
      #    track       (required) : name of the track
      #    artist      (required) : name of the artist of the track
      #    time        (required) : a time object set to the time the track started playing
      #    album                  : Name of the album
      #    albumArtist            : Name of the album artist if artist differs
      #    trackNumber            : Number of the track
      #    mbid                   : MusicBrainz ID of the track
      #    duration               : track length
      def scrobble(params = {})
        if params[:session_key].blank? || params[:track].blank? || params[:time].nil? || params[:artist].blank?
          raise ArgumentError, "Missing required argument"
        end

        query = {
          :sk           => params[:session_key],
          "track[0]"    => params[:track],
          "timestamp[0]"=> params[:time].utc.to_i,
          "artist[0]"   => params[:artist]
        }

        query["album[0]"]       = params[:album] if !params[:album].blank?
        query["albumArtist[0]"] = params[:albumArtist] if !params[:albumArtist].blank?
        query["trackNumber[0]"] = params[:trackNumber] if !params[:trackNumber].blank?
        query["mbid[0]"]        = params[:mbid] if !params[:mbid].blank?
        query["duration[0]"]    = params[:duration] if !params[:duration].blank?
        
        doc = Hpricot::XML(Track.connection.post("track.scrobble", true, query))

        if doc.at("lfm")["status"] == "failed"
          case doc.at("lfm").at("error")["code"].to_i
            when 9
              raise BadSessionError, doc.at("lfm").at("error").inner_html
            when 11, 16
              raise UnavailableError, doc.at("lfm").at("error").inner_html
           else
              raise RequestFailedError, doc.at("lfm").at("error").inner_html
           end
        end
 
        doc.at("lfm")["status"]
       end

      # Update the current playing song
      #
      # Possible parameters:
      #    session_key (required) : the session key you got during authentification
      #    track       (required) : name of the track
      #    artist      (required) : name of the artist of the track
      #    album                  : Name of the album
      #    albumArtist            : Name of the album artist if artist differs
      #    trackNumber            : Number of the track
      #    mbid                   : MusicBrainz ID of the track
      #    duration               : track length
      def updateNowPlaying(params = {})
        if params[:session_key].blank? || params[:track].blank? || params[:artist].blank?
          raise ArgumentError, "Missing required argument"
        end

        query = {
          :sk        => params[:session_key],
          "track"    => params[:track],
          "artist"   => params[:artist]
        }

        query["album"]       = params[:album] if !params[:album].blank?
        query["albumArtist"] = params[:albumArtist] if !params[:albumArtist].blank?
        query["trackNumber"] = params[:trackNumber] if !params[:trackNumber].blank?
        query["mbid"]        = params[:mbid] if !params[:mbid].blank?
        query["duration"]    = params[:duration] if !params[:duration].blank?
        
        doc = Hpricot::XML(Track.connection.post("track.updateNowPlaying", true, query))

        if doc.at("lfm")["status"] == "failed"
          case doc.at("lfm").at("error")["code"].to_i
            when 9
              raise BadSessionError, doc.at("lfm").at("error").inner_html
            when 11, 16
              raise UnavailableError, doc.at("lfm").at("error").inner_html
           else
              raise RequestFailedError, doc.at("lfm").at("error").inner_html
           end
        end
        
        doc.at("lfm")["status"]
      end
 
    end
    
    def initialize(artist, name, o={})
      raise ArgumentError, "Artist is required" if artist.blank?
      raise ArgumentError, "Name is required" if name.blank?
      @artist = artist
      @name = name

      options = {:include_info => false}.merge(o)
      load_info if options[:include_info]
    end

    def load_info(xml=nil)
      unless xml
        doc = self.class.fetch_and_parse("track.getInfo", {:artist => @artist, :track => @name})
        xml = (doc / :track).first
      end

      return self if xml.nil?

      self.artist_mbid   = (xml).at(:artist)['mbid']               if (xml).at(:artist) && (xml).at(:artist)['mbid']
      self.artist_mbid   = (xml).at(:artist).at(:mbid).inner_html  if artist_mbid.nil? && (xml).at(:artist) && (xml).at(:artist).at(:mbid)
      self.mbid          = (xml).at(:mbid).inner_html              if (xml).at(:mbid)
      self.playcount     = (xml).at(:playcount).inner_html         if (xml).at(:playcount)
      self.chartposition = self.rank = xml['rank']                 if xml['rank']
      self.url           = Base.fix_url((xml).at(:url).inner_html) if (xml).at(:url)
      self.streamable    = (xml).at(:track)['streamable']          if (xml).at(:track) && (xml).at(:track)['streamable']
      self.streamable    = (xml).at(:streamable).inner_html == '1' ? 'yes' : 'no' if streamable.nil? && (xml).at(:streamable)
      self.duration      = (xml).at(:duration).inner_html.to_i     if (xml).at(:duration)
        
      self.count         = xml['count']                            if xml['count']
      self.album         = (xml).at(:album).inner_html             if (xml).at(:album)
      self.album_mbid    = (xml).at(:album)['mbid']                if (xml).at(:album) && (xml).at(:album)['mbid']
      self.date          = Base.parse_time((xml).at(:date).inner_html)  if (xml).at(:date)
      self.date_uts      = (xml).at(:date)['uts']                  if (xml).at(:date) && (xml).at(:date)['uts']

      if wiki_xml = xml.at(:wiki)
        self.summary     = wiki_xml.at(:summary).to_plain_text     if wiki_xml.at(:summary)
        self.content     = wiki_xml.at(:content).to_plain_text     if wiki_xml.at(:content)
      end

      self.images = {}
      (xml/'image').each {|image|
        self.images[image['size']] = image.inner_html if self.images[image['size']].nil?
      }
        
      self.thumbnail = images['small']
      self.image     = images['medium']

      self
    end
      
    def albums(force=false)
      get_instance("track.getInfo", :albums, :album, {:track => @name, :artist => @artist}, force)
    end
        
    def fans(force=false)
      get_instance("track.getTopFans", :fans, :user, {:track => @name, :artist => @artist}, force)
    end
    
    def tags(force=false)
      get_instance("track.getTopTags", :tags, :tag, {:track => @name, :artist => @artist}, force)
    end
    
    # The session_key is returned by auth.session.key
    def love(session_key)
      Track.love(@artist, @name, session_key)
    end

    # scrobble this track
    #   time :       a time object set to the time the track started playing
    #   session_key: the session key you got during authentification
    def scrobble(time, session_key)
      Track.scrobble({
        :session_key => session_key,
        :time        => time,
        :track       => @name,
        :artist      => @artist,
        :album       => @album,
        :mbid        => @mbid
      })
    end

    # inform last.fm that this track is currently playing
    #   time :       a time object set to the time the track started playing
    #   session_key: the session key you got during authentification
    def updateNowPlaying(time, session_key)
      Track.updateNowPlaying({
        :session_key => session_key,
        :time        => time,
        :track       => @name,
        :artist      => @artist,
        :album       => @album,
        :mbid        => @mbid
      })
    end

  end
end
