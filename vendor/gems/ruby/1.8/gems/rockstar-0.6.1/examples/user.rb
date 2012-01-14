require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'rockstar'))

# Please enter your API-Keys into lastfm.yml first. 
# You can find them here : http://www.lastfm.de/api/account
Rockstar.lastfm = YAML.load_file(File.join(File.dirname(__FILE__), 'lastfm.yml'))

user = Rockstar::User.new('jnunemaker')

puts "#{user.username}'s Recent Tracks"
puts "=" * (user.username.length + 16)
user.recent_tracks.each { |t| puts t.name }

puts
puts

puts "#{user.username}'s Top Tracks"
puts "=" * (user.username.length + 13)
user.top_tracks.each { |t| puts "(#{t.playcount}) #{t.name}" }
