module Rockstar
  class Venue < Base
    
    attr_accessor :vid, :name, :city, :country, :street, :postalcode, :lat, :long, :url,
                  :website, :phonenumber, :images, :events

    class << self
      def new_from_xml(xml, doc)
        v = Venue.new(
          (xml).at(:id).inner_html, 
          (xml).at(:name).inner_html
        )

        v.city       = xml.search("/location/city").inner_html.strip
        v.country    = xml.search("/location/country").inner_html.strip
        v.street     = xml.search("/location/street").inner_html.strip
        v.postalcode = xml.search("/location/postalcode").inner_html.strip
        v.lat        = xml.search("geo:lat").inner_html.strip
        v.long       = xml.search("geo:long").inner_html.strip
        v.url        = xml.search("/url").inner_html.strip
        v.website    = xml.search("/website").inner_html.strip
        v.phonenumber= xml.search("/phonenumber").inner_html.strip

        v.images = {}
        xml.search('/image').each {|image|
          v.images[image['size']] = image.inner_html if v.images[image['size']].nil?
        }

        v
      end
    end
    
    def initialize(id, name)
      raise ArgumentError, "ID is required" if id.blank?
      raise ArgumentError, "Name is required" if name.blank?
      @vid  = id
      @name = name
    end
    
    def image(which=:medium)
      which = which.to_s
      raise ArgumentError unless ['small', 'medium', 'large', 'extralarge', 'mega'].include?(which)  
      if (self.images.nil?)
        load_info
      end    
      self.images[which]
    end
    
    def self.find(name, country = nil, limit = nil, page = nil)
      get_instance("venue.search", :venues, :venue, {:venue => name, :country => country, :limit => limit, :page => page})
    end
    
    def events
      @events ||= get_instance("venue.getEvents", :events, :event, {:venue => vid})
    end
  end
end


