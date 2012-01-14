module Rockstar 
  
  API_URL     = 'http://ws.audioscrobbler.com/'
  API_VERSION = '2.0'
  
  class Base
    class << self
      def connection
        @connection ||= REST::Connection.new(API_URL + API_VERSION + "/")
      end
      
      def fetch_and_parse(resource, params = {}, sign_request = false)
        Hpricot::XML(connection.get(resource, sign_request, params))
      end

    end
    
    private
      # in order for subclass to use, it must have api_path method
      def get_instance(api_method, instance_name, element, params, force=false, sign_request = false)
        rockstar_class = "rockstar/#{element.to_s}".camelize.constantize
        
        if instance_variable_get("@#{instance_name}").nil? || force
          doc      = self.class.fetch_and_parse(api_method, params, sign_request)
          elements = (doc/element).inject([]) { |elements, el| elements << rockstar_class.new_from_xml(el, doc); elements }
          instance_variable_set("@#{instance_name}", elements)
        end
        instance_variable_get("@#{instance_name}")
      end
      
      def self.fix_url(url)
        if (!url.blank? && !url.match("^http://"))
          url = "http://#{url}"
        end
        url
      end

      def self.parse_time(time_str)
        return nil if time_str.blank?
        Time.parse(time_str)
      end
  end
end
