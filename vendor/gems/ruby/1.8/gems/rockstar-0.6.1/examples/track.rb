require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'rockstar'))
require 'pp'

# Please enter your API-Keys into lastfm.yml first. 
# You can find them here : http://www.lastfm.de/api/account
Rockstar.lastfm = YAML.load_file(File.join(File.dirname(__FILE__), 'lastfm.yml'))

track = Rockstar::Track.new('Carrie Underwood', 'Before He Cheats')
puts 'Fans'
puts "=" * 4
track.fans.each { |u| puts "(#{u.weight}) #{u.username}" }

track = Rockstar::Track.new('U2 & Green Day', 'The Saints Are Coming')
pp track.tags
