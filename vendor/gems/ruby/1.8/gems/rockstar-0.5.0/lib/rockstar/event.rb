module Rockstar
  class Event < Base
    
    attr_accessor :eid, :title, :artists, :headliners, :start_date, :end_date,
                  :description, :attendance, :reviews, :tag, :url, :website, :tickets, 
                  :cancelled, :tags, :images, :venue
    
    class << self
      def new_from_xml(xml, doc)
        e = Event.new(
          (xml).at(:id).inner_html, 
          (xml).at(:title).inner_html
        )

        e.artists = []
        xml.search("/artists/artist").each {|a|
          e.artists << a.inner_html
        }

        e.headliners = []
        xml.search("/artists/headliner").each{|h|
          e.headliners <<  h.inner_html
        }

        e.start_date  = Base.parse_time(xml.search("/startDate").inner_html.strip)
        e.end_date    = Base.parse_time(xml.search("/endDate").inner_html.strip)
        e.description = xml.search("/description").inner_html.strip
        e.attendance  = xml.search("/attendance").inner_html.strip.to_i
        e.reviews     = xml.search("/reviews").inner_html.strip.to_i
        e.tag         = xml.search("/tag").inner_html.strip
        e.url         = xml.search("/url").inner_html.strip
        e.website     = xml.search("/website").inner_html.strip
        e.cancelled   = xml.search("/cancelled").inner_html.strip == 1

        e.tickets = []
        xml.search("/tickets/ticket").each{|t|
          e.tickets << t.inner_html
        }

        e.tags = []
        xml.search("/tags/tag").each{|t|
          e.tags << t.inner_html
        }

        e.images = {}
        xml.search('/image').each {|image|
          e.images[image['size']] = image.inner_html
        }

        e.venue = Venue.new_from_xml(xml.search('/venue'), doc) if xml.search('/venue')

        e
      end
    end
    
    def initialize(id, title)
      raise ArgumentError, "ID is required" if id.blank?
      raise ArgumentError, "Title is required" if title.blank?
      @eid   = id
      @title = title
    end
    
    def image(which=:medium)
      which = which.to_s
      raise ArgumentError unless ['small', 'medium', 'large', 'extralarge', 'mega'].include?(which)  
      if (self.images.nil?)
        load_info
      end    
      self.images[which]
    end
  end
end

