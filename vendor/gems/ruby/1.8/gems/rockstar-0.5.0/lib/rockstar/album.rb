# Getting information about an album such as release date and the summary or description on it is very easy.
# 
#   album = Rockstar::Album.new('Carrie Underwood', 'Some Hearts', :include_info => true)
# 
#   puts "Album: #{album.name}"
#   puts "Artist: #{album.artist}"
#   puts "URL: #{album.url}"
#   puts "Release Date: #{album.release_date.strftime('%m/%d/%Y')}"
# 
# Would output:
#
#   Album: Some Hearts
#   Artist: Carrie Underwood
#   URL: http://www.last.fm/music/Carrie+Underwood/Some+Hearts
#   Release Date: 11/15/2005
# 
module Rockstar
  class Album < Base
    attr_accessor :artist, :artist_mbid, :name, :mbid, :playcount, :rank, :url, :release_date
    attr_accessor :image_large, :image_medium, :image_small, :summary, :content, :images
    
    # needed on top albums for tag
    attr_accessor :count, :streamable
    
    # needed for weekly album charts
    attr_accessor :chartposition
    
    class << self
      def find(artist, name, o={})
        new(artist, name, o)
      end
      
      def new_from_xml(xml, doc=nil)
        name             = (xml).at(:name).inner_html                  if (xml).at(:name)
        name             = xml['name']                                 if name.nil? && xml['name']
        artist           = (xml).at(:artist).at(:name).inner_html      if (xml).at(:artist) && (xml).at(:artist).at(:name)
        artist           = (xml).at(:artist).inner_html                if artist.nil? && (xml).at(:artist)
        artist           = doc.root['artist']                          if artist.nil? && doc.root['artist']
        a                = Album.new(artist, name)
        a.artist_mbid    = (xml).at(:artist)['mbid']                   if (xml).at(:artist) && (xml).at(:artist)['mbid']
        a.artist_mbid    = (xml).at(:artist).at(:mbid).inner_html      if a.artist_mbid.nil? && (xml).at(:artist) && (xml).at(:artist).at(:mbid)
        a.mbid           = (xml).at(:mbid).inner_html                  if (xml).at(:mbid)
        a.playcount      = (xml).at(:playcount).inner_html             if (xml).at(:playcount)
        a.rank           = xml['rank']                                 if xml['rank']
        a.rank           = (xml).at(:rank).inner_html                  if (xml).at(:rank) if a.rank.nil?
        a.url            = Base.fix_url((xml).at(:url).inner_html)     if (xml).at(:url)
        
        a.chartposition  = a.rank
        
        a.images = {}
        (xml/'image').each {|image|
          a.images[image['size']] = image.inner_html
        }
        
        a.image_large    = a.images['large']
        a.image_medium   = a.images['medium']
        a.image_small    = a.images['small']
        
        # needed on top albums for tag
        a.count          = xml['count'] if xml['count']
        a.streamable     = xml['streamable'] if xml['streamable']
        a
      end
    end
    
    def initialize(artist, name, o={})
      raise ArgumentError, "Artist is required" if artist.blank?
      raise ArgumentError, "Name is required" if name.blank?
      @artist = artist
      @name   = name
      options = {:include_info => false}.merge(o)
      load_info() if options[:include_info]
    end
    
    def load_info
      doc           = self.class.fetch_and_parse("album.getInfo", {:artist => @artist, :album =>@name})
      @url          = Base.fix_url((doc).at(:url).inner_html)
      @release_date = Base.parse_time((doc).at(:releasedate).inner_html.strip)

      @images = {}
      (doc/'image').each {|image|
        @images[image['size']] = image.inner_html
      }

      @image_large    = @images['large']
      @image_medium   = @images['medium']
      @image_small    = @images['small']

      @mbid         = (doc).at(:mbid).inner_html
      @summary      = (doc).at(:summary).to_plain_text
      @content      = (doc).at(:content).to_plain_text
    end
    
    def tracks
      warn "[DEPRECATION] `tracks` is deprecated. The current api doesn't offer this function"
      []
    end
    
    def image(which=:small)
      which = which.to_s
      raise ArgumentError unless ['small', 'medium', 'large', 'extralarge'].include?(which)  
      if (self.images.nil?)
        load_info
      end    
      self.images[which]
    end
  end
end
