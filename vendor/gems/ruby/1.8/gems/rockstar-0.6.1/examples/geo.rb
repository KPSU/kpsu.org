require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'rockstar'))

# Please enter your API-Keys into lastfm.yml first. 
# You can find them here : http://www.lastfm.de/api/account
Rockstar.lastfm = YAML.load_file(File.join(File.dirname(__FILE__), 'lastfm.yml'))

geo = Rockstar::Geo.new

geo.events(:location => 'london').each{|e| p "#{e.title} at #{e.venue.name}"}
