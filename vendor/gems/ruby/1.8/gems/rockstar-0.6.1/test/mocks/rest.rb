require File.dirname(__FILE__) + '/../../lib/rockstar/rest'
require 'digest/md5'

module Rockstar
  module REST
  	class Connection

      def flatten(arg)
        if arg.class == Hash
          return arg.keys.sort_by{|a|a.to_s}.collect { |k| "%s_%s" % [k.to_s, flatten(arg[k])] }.join("_").gsub(" ", "_")
        end
        arg.to_s
      end

  	  # reads xml fixture file instead of hitting up the internets
  	  def request(resource, method = "get", args = {}, sign_request=false)
  	    @now_playing_url = 'http://62.216.251.203:80/nowplaying'
  	    @submission_url = 'http://62.216.251.205:80/protocol_1.2'
  	    @session_id = '17E61E13454CDD8B68E8D7DEEEDF6170'
  	    
  	    if @base_url == Rockstar::API_URL + Rockstar::API_VERSION + "/"
  	      folder, file = resource.downcase.split(".")
  	      
  	      query = ""
  	      if args.size > 0
  	        query = "_" + flatten(args)
          end
  	      
  	      file = File.dirname(__FILE__) + "/../fixtures/xml/#{folder}/#{file}#{query}.xml"
  	      
  	      if (!File.exists? file)
            puts "Mock file not found : #{file}"
  	      else
      	    File.read(file)
  	      end
  	        	      
  	    elsif @base_url == Rockstar::AUTH_URL
  	      # Test Simple Auth
          if args[:hs] == "true" && args[:p] == Rockstar::AUTH_VER.to_s && args[:c] == 'rck' &&
             args[:v] == Rockstar::Version.to_s && args[:u] == 'chunky' && !args[:t].blank?
            
            "OK\n#{@session_id}\n#{@now_playing_url}\n#{@submission_url}"
          
          # Test Token Auth
          elsif args[:u]=="chunky" && args[:a]==Digest::MD5.hexdigest("secret#{Time.now.to_i}") && args[:v]=="0.3.0" &&
                args[:c]=="rck" && args[:sk]=="bacon" && args[:hs]=="true" &&
                args[:p]=="1.2.1" && args[:t]==Time.now.to_i.to_s
               
            "OK\n#{@session_id}\n#{@now_playing_url}\n#{@submission_url}"
          else
            puts "WRONG!!"
          end
        elsif @base_url == @now_playing_url
          if args[:s] == @session_id && args.length == 7 && ![args[:a], args[:t], args[:b], args[:n]].any?(&:blank?)
             'OK'
          end           
        elsif @base_url == @submission_url
          if args[:s] == @session_id && args.length == 10 &&
             ![args['a[0]'], args['t[0]'], args['i[0]'], args['o[0]'], args['l[0]'], args['b[0]']].any?(&:blank?)
            'OK'
          end
	      end
	      
	    end
	  end
  end
end
