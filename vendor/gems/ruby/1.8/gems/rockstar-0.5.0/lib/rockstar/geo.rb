module Rockstar
  class Geo < Base
    
      
    # Get events in a specific location. Opts can be
    #
    # * :location => 'madrid'  # A city name from geo.metros
    # * :lat => 50.0, :long => 14.0 # A geo point
    #
    # Additionally you can set the distance from that point with
    #   :distance => 50 # 50 km from the given location
    # 
    def events(opts = {}, force = false)
      get_instance("geo.getEvents", :events, :event, opts, force) 
    end

    def metros(country, force = false)
      get_instance("geo.getMetros", :metros, :metro, {:country => country}, force)
    end

  end
end
