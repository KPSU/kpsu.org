require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'rockstar'))

# Please enter your API-Keys into lastfm.yml first. 
# You can find them here : http://www.lastfm.de/api/account
Rockstar.lastfm = YAML.load_file(File.join(File.dirname(__FILE__), 'lastfm.yml'))

artist = Rockstar::Artist.new('Metallica')

puts 'Top Tracks'
puts "=" * 10
artist.top_tracks.each { |t| puts "#{t.name}" }

puts

puts 'Events'
puts '=' * 10
artist.events.each { |e| puts "#{e.venue.city} at #{e.venue.name} on #{e.start_date.strftime("%D")}" }

puts

puts 'Similar Artists'
puts "=" * 15
artist.similar.each { |a| puts "(#{a.match}%) #{a.name}" }
