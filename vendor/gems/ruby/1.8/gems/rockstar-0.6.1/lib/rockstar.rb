$: << File.expand_path(File.dirname(__FILE__))

require 'rubygems'
require 'cgi'
require 'hpricot'
require 'active_support'
require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/string/inflections'
require 'time'
require 'yaml'

require 'rockstar/base'
require 'rockstar/version'

require 'rockstar/album'
require 'rockstar/artist'
require 'rockstar/chart'
require 'rockstar/event'
require 'rockstar/geo'
require 'rockstar/metro'
require 'rockstar/user'
require 'rockstar/tag'
require 'rockstar/track'
require 'rockstar/venue'

require 'rockstar/simpleauth'
require 'rockstar/auth'
require 'rockstar/session'
require 'rockstar/tokenauth'
require 'rockstar/scrobble'
require 'rockstar/playing'

require 'rockstar/rest'

module Rockstar
  extend self
  
  def lastfm=(args)
    @api_key    = args["api_key"]
    @api_secret = args["api_secret"]
  end
  
  def lastfm_api_key
    @api_key
  end
  
  def lastfm_api_secret
    @api_secret
  end
end
