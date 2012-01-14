require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'rockstar'))

# Please enter your API-Keys into lastfm.yml first. 
# You can find them here : http://www.lastfm.de/api/account
Rockstar.lastfm = YAML.load_file(File.join(File.dirname(__FILE__), 'lastfm.yml'))

tag = Rockstar::Tag.new('country')

puts 'Top Tags '
Rockstar::Tag.top_tags.each { |a| puts "(#{a.count}) #{a.name}" }

puts

puts 'Top Albums'
tag.top_albums.each { |a| puts "(#{a.count}) #{a.name} by #{a.artist}" }

puts

puts 'Top Tracks'
tag.top_tracks.each { |t| puts "(#{t.count}) #{t.name} by #{t.artist}" }
