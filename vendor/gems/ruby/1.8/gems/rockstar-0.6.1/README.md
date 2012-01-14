# Rockstar

Rockstar is a wrapper for the last.fm audioscrobbler web services (http://www.last.fm/api/). This gem is based on the scrobbler
gem by John Nunemaker and was updated to use the 2.0 version of the last.fm api

Below is just a sampling of how easy this lib is to use.

Please initialize your api key and secret before using the api:

    Rockstar.lastfm = YAML.load_file('lastfm.yml')

Here is an example lastfm.yml:

    api_key: "API"
    api_secret: "SECRET"    

If you want to use the api in an rails app, you could add an initializer in config/initializers/lastm.rb and load a config/lastfm.yml file.

    rails_root = ENV['RAILS_ROOT'] || File.dirname(__FILE__) + '/../..'
    Rockstar.lastfm =  YAML.load_file(rails_root + '/config/lastfm.yml')

## Users

    user = Rockstar::User.new('jnunemaker')

    puts "#{user.username}'s Recent Tracks"
    puts "=" * (user.username.length + 16)
    user.recent_tracks.each { |t| puts t.name }

    puts
    puts

    puts "#{user.username}'s Top Tracks"
    puts "=" * (user.username.length + 13)
    user.top_tracks.each { |t| puts "(#{t.playcount}) #{t.name}" }
    
## Albums
    
    album = Rockstar::Album.new('Carrie Underwood', 'Some Hearts', :include_info => true)

    puts "Album: #{album.name}"
    puts "Artist: #{album.artist}"
    puts "URL: #{album.url}"
    puts "Release Date: #{album.release_date.strftime('%m/%d/%Y')}"

## Artists
    
    artist = Rockstar::Artist.new('Carrie Underwood')

    puts 'Top Tracks'
    puts "=" * 10
    artist.top_tracks.each { |t| puts "(#{t.name}" }

    puts

    puts 'Similar Artists'
    puts "=" * 15
    artist.similar.each { |a| puts "(#{a.match}%) #{a.name}" }
    
## Tags    
    
    tag = Rockstar::Tag.new('country')

    puts 'Top Albums'
    tag.top_albums.each { |a| puts "(#{a.count}) #{a.name} by #{a.artist}" }

    puts

    puts 'Top Tracks'
    tag.top_tracks.each { |t| puts "(#{t.count}) #{t.name} by #{t.artist}" }
    
## Tracks
    
    track = Rockstar::Track.new('Carrie Underwood', 'Before He Cheats')
    puts 'Fans'
    puts "=" * 4
    track.fans.each { |u| puts "(#{u.weight}) #{u.username}" }
    
    # Love a song, session_key is returned by Rockstar::Auth. See Rockstar::TokenAuth or
    # examples/scrobble.rb for a complete example
    track.love(session_key)

## Geo

    geo = Rockstar::Geo.new
      
    # Get events for a lat/long  
    geo.events(:lat => 50.0, :long => 12.3).each{|e| p "#{e.title} at #{e.venue.name}"}
    
    # Get events for a location
    geo.events(:location => 'london').each{|e| p "#{e.title} at #{e.venue.name}"}
    
    # To get a list of possible locations use
    geo.metros("germany").each{|m| p m.name}


##  Get rights to access the user data for scrobbing, now playing, events etc...

    a = Rockstar::Auth.new
    token = a.token
    
    puts
    puts "Please open http://www.last.fm/api/auth/?api_key=#{Rockstar.lastfm_api_key}&token=#{token}"
    puts
    puts "Press enter when done."
    
    gets
    
    session = a.session(token)

You can store the session.key somewhere and use it from now on to identify the user.

## Scrobbling

    track = Rockstar::Track.new('Carrie Underwood', 'Before He Cheats')
    track.scrobble(Time.now, session.key)

## Now Playing Submission

    track = Rockstar::Track.new('Carrie Underwood', 'Before He Cheats')
    track.updateNowPlaying(Time.now, session.key)

## Note on Patches/Pull Requests
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2007-2011 John Nunemaker, Bodo "Bitboxer" Tasche, Nick "zapnap" Plante. See LICENSE for details.
