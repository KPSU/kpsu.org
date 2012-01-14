require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'rockstar'))

# Please enter your API-Keys into lastfm.yml first. 
# You can find them here : http://www.lastfm.de/api/account
Rockstar.lastfm = YAML.load_file(File.join(File.dirname(__FILE__), 'lastfm.yml'))

# This is the desktop app aproach to token auth. See Rockstar::TokenAuth for
# details on how to get a token for a web app.

a = Rockstar::Auth.new
token = a.token

puts
puts "Please open http://www.last.fm/api/auth/?api_key=#{Rockstar.lastfm_api_key}&token=#{token}"
puts
puts "Press enter when done."

gets

session = a.session(token)

Rockstar::Track.scrobble(
  :session_key  => session.key,
  :track        => "Viva La Vida",
  :artist       => "Coldplay",
  :album        => "Viva La Vida",
  :time         => Time.new,
  :length       => 244,
  :track_number => 7
)

# Love the Song :
l_status = Rockstar::Track.new('Coldplay', 'Viva La Vida').love(session.key)

puts "Love track status : #{l_status}"

Rockstar::Track.updateNowPlaying(
  :session_key  => session.key,
  :track        => "Viva La Vida",
  :artist       => "Coldplay",
  :album        => "Viva La Vida",
  :time         => Time.new,
  :length       => 244,
  :track_number => 7
)
