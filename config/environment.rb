# Load the rails application
require File.expand_path('../application', __FILE__)
require 'open-uri'
require 'digest/md5'
require 'amazon/aws/search'
require 'rbrainz'
include MusicBrainz

# Initialize the rails application
Kpsu::Application.initialize!
