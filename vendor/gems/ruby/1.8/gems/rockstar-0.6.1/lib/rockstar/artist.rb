# Below are examples of how to find an artists top tracks and similar artists.
# 
#   artist = Rockstar::Artist.new('Carrie Underwood')
# 
#   puts 'Top Tracks'
#   puts "=" * 10
#   artist.top_tracks.each { |t| puts "#{t.name}" }
# 
#   puts
# 
#   puts 'Similar Artists'
#   puts "=" * 15
#   artist.similar.each { |a| puts "(#{a.match}%) #{a.name}" }
# 
# Would output something similar to:
# 
#   Top Tracks
#   ==========
#   (8797) Before He Cheats
#   (3574) Don't Forget to Remember Me
#   (3569) Wasted
#   (3246) Some Hearts
#   (3142) Jesus, Take the Wheel
#   (2600) Starts With Goodbye
#   (2511) Jesus Take The Wheel
#   (2423) Inside Your Heaven
#   (2328) Lessons Learned
#   (2040) I Just Can't Live a Lie
#   (1899) Whenever You Remember
#   (1882) We're Young and Beautiful
#   (1854) That's Where It Is
#   (1786) I Ain't in Checotah Anymore
#   (1596) The Night Before (Life Goes On)
#   
#   Similar Artists
#   ===============
#   (100%) Rascal Flatts
#   (84.985%) Keith Urban
#   (84.007%) Kellie Pickler
#   (82.694%) Katharine McPhee
#   (81.213%) Martina McBride
#   (79.397%) Faith Hill
#   (77.121%) Tim McGraw
#   (75.191%) Jessica Simpson
#   (75.182%) Sara Evans
#   (75.144%) The Wreckers
#   (73.034%) Kenny Chesney
#   (71.765%) Dixie Chicks
#   (71.084%) Kelly Clarkson
#   (69.535%) Miranda Lambert
#   (66.952%) LeAnn Rimes
#   (66.398%) Mandy Moore
#   (65.817%) Bo Bice
#   (65.279%) Diana DeGarmo
#   (65.115%) Gretchen Wilson
#   (62.982%) Clay Aiken
#   (62.436%) Ashlee Simpson
#   (62.160%) Christina Aguilera
module Rockstar
  class Artist < Base
    attr_accessor :name, :mbid, :playcount, :rank, :url, :thumbnail
    attr_accessor :summary, :content, :images, :count, :streamable
    attr_accessor :chartposition
    
    # used for similar artists
    attr_accessor :match
    
    class << self
      def new_from_xml(xml, doc=nil)
        # occasionally name can be found in root of artist element (<artist name="">) rather than as an element (<name>)
        name             = (xml).at(:name).inner_html           if (xml).at(:name)
        name             = xml['name']                          if name.nil? && xml['name']

        artist = Artist.new(name)
        artist.load_info(xml)
        artist
      end
    end
    
    def initialize(name, o={})
      raise ArgumentError, "Name is required" if name.blank?
      @name = name

      options = {:include_info => false}.merge(o)
      load_info if options[:include_info]
    end

    def load_info(xml=nil)
      unless xml
        doc = self.class.fetch_and_parse("artist.getInfo", {:artist => @name})
        xml = (doc / :artist).first
      end

      return self if xml.nil?

      self.mbid           = (xml).at(:mbid).inner_html              if (xml).at(:mbid)
      self.playcount      = (xml).at(:playcount).inner_html         if (xml).at(:playcount)
      self.chartposition  = self.rank = xml['rank']                 if xml['rank']
      self.chartposition  = self.rank = (xml).at(:rank).inner_html  if (xml).at(:rank) if self.rank.nil?
      self.url            = Base.fix_url((xml).at(:url).inner_html) if (xml).at(:url)

      if bio_xml = xml.at(:bio)
        self.summary      = bio_xml.at(:summary).to_plain_text      if bio_xml.at(:summary)
        self.content      = bio_xml.at(:content).to_plain_text      if bio_xml.at(:content)
      end

      self.images = {}
      (xml/'image').each {|image|
        self.images[image['size']] = image.inner_html if self.images[image['size']].nil?
      }
      
      self.thumbnail      = self.images['small']
      self.match          = (xml).at(:match).inner_html          if (xml).at(:match)
       
      # in top artists for tag
      self.count          = xml['count']                         if xml['count']
      self.streamable     = xml['streamable']                    if xml['streamable']

      self.streamable     = (xml).at(:streamable).inner_html == '1' ? 'yes' : 'no' if self.streamable.nil? && (xml).at(:streamable)

      self
    end
    
    def current_events(format=:ics)
      warn "[DEPRECATION] the `current_events` method is deprecated. Please use artist.events"
      events
    end

    def events(force=false)
      get_instance("artist.getEvents", :events, :event, {:artist => @name}, force)
    end
    
    def similar(force=false)
      get_instance("artist.getSimilar", :similar, :artist, {:artist => @name}, force)
    end
    
    def top_fans(force=false)
      get_instance("artist.getTopFans", :top_fans, :user, {:artist => @name}, force)
    end
    
    def top_tracks(force=false)
      get_instance("artist.getTopTracks", :top_tracks, :track, {:artist => @name}, force)
    end
    
    def top_albums(force=false)
      get_instance("artist.getTopAlbums", :top_albums, :album, {:artist => @name}, force)
    end
    
    def top_tags(force=false)
      get_instance("artist.getTopTags", :top_tags, :tag, {:artist => @name}, force)
    end

    def image(which=:medium)
      which = which.to_s
      raise ArgumentError unless ['small', 'medium', 'large', 'extralarge'].include?(which)
      load_info if self.images.nil?
      self.images[which]
    end

    def user_images(opts={})
      if mbid.nil?
        opts[:artist] = name
      else
        opts[:mbid] = mbid
      end

      images = []
      image_doc = self.class.fetch_and_parse("artist.getImages", opts, false)
      (image_doc/'image').each do |xml|
        image_sizes = {}
        xml.search('/sizes/size').each do |image|
          image_sizes[image['name']] = image.inner_html
        end

        images << image_sizes
      end

      images
    end
  end
end
