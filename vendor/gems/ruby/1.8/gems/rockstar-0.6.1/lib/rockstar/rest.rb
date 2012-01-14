require 'net/https'
require 'digest/md5'

module Rockstar
  module REST
  	class Connection
  		def initialize(base_url, args = {})
  			@base_url = base_url
  			@username = args[:username]
  			@password = args[:password]
  		end

  		def get(resource, sign_request, args = {})
  			request(resource, "get", args, sign_request)
  		end

  		def post(resource, sign_request, args = nil)
  			request(resource, "post", args, sign_request)
  		end

  		def request(resource, method = "get", args = {}, sign_request=false)
  		 	url = URI.parse(@base_url)
        
        if (!resource.blank?)
          args[:method] = resource
          args[:api_key]= Rockstar.lastfm_api_key
        end
        
  			if args
  			  sorted_keys = args.keys.sort_by{|k|k.to_s}
          query = sorted_keys.collect { |k| "%s=%s" % [escape(k.to_s), escape(args[k].to_s)] }.join("&")

          if !args[:sk].nil? ||sign_request # Session Key available => sign the request or sign_request = true?
            signed = sorted_keys.collect {|k| "%s%s" % [k.to_s, args[k].to_s]}.join()
            
            auth = Digest::MD5.hexdigest("#{signed}#{Rockstar.lastfm_api_secret}")
            query += "&api_sig=#{auth}"
          end
  				url.query = query
  			end

       	case method
  			when "get"
  				req = Net::HTTP::Get.new(url.request_uri)
  			when "post"
  				req = Net::HTTP::Post.new(url.request_uri)
  			end

  			if @username and @password
  				req.basic_auth(@username, @password)
  			end

  			http = Net::HTTP.new(url.host, url.port)
  			http.use_ssl = (url.port == 443)

  			res = http.start() { |conn| conn.request(req) }
  			res.body
  		end
  		
  		private
  		  def escape(str)
  		    URI.escape(str, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
  		  end
  	end
  end
end
