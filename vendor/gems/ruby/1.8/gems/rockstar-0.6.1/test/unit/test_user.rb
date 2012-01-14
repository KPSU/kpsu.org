# encoding: utf-8
require File.expand_path('../../test_helper.rb', __FILE__)

class TestUser < Test::Unit::TestCase

  def setup
    @user = Rockstar::User.new('jnunemaker')
  end
  
  test 'should be able to find one user' do
    assert_equal(@user.username, Rockstar::User.find('jnunemaker').username)
  end
  
  test 'should be able to find multiple users' do
    users = Rockstar::User.find('jnunemaker', 'oaknd1', 'wharle')
    assert_equal(%w{jnunemaker oaknd1 wharle}, users.collect(&:username))
  end
  
  test 'should be able to find multiple users using an array' do
    users = Rockstar::User.find(%w{jnunemaker oaknd1 wharle})
    assert_equal(%w{jnunemaker oaknd1 wharle}, users.collect(&:username))
  end
  
  test 'should be able to load profile while finding' do
    user = Rockstar::User.find('jnunemaker', :include_profile => true)
    assert_equal(@user.username, user.username)
    assert_equal('3017870', user.id)
  end
  
  test 'should be able to load profile while finding multiple users' do
    users = Rockstar::User.find('jnunemaker', 'oaknd1', 'wharle', :include_profile => true)
    assert_equal(3, users.size)
  end
  
  test 'should be able to include profile during initialization' do
    user = Rockstar::User.new('jnunemaker', :include_profile => true)
    assert_equal('3017870', user.id)
    assert_equal('http://www.last.fm/user/jnunemaker', user.url)
    assert_equal('John Nunemaker', user.realname)
    assert_equal('2005-12-08 13:58', user.registered)
    assert_equal('1134050307', user.registered_unixtime)
    assert_equal('28', user.age)
    assert_equal('m', user.gender)
    assert_equal('US', user.country)
    assert_equal('35853', user.playcount)
    assert_equal('http://userserve-ak.last.fm/serve/34/4994806.jpg', user.avatar)
  end

  test 'should be able to load users profile' do
    @user.load_profile
    assert_equal('3017870', @user.id)
    assert_equal('http://www.last.fm/user/jnunemaker', @user.url)
    assert_equal('John Nunemaker', @user.realname)
    assert_equal('2005-12-08 13:58', @user.registered)
    assert_equal('1134050307', @user.registered_unixtime)
    assert_equal('28', @user.age)
    assert_equal('m', @user.gender)
    assert_equal('US', @user.country)
    assert_equal('35853', @user.playcount)
    assert_equal('http://userserve-ak.last.fm/serve/34/4994806.jpg', @user.avatar)
  end

  test "should be able to get a user's top artists" do
    assert_equal(50, @user.top_artists.size)
    first = @user.top_artists.first
    assert_equal('Taylor Swift', first.name)
    assert_equal('20244d07-534f-4eff-b4d4-930878889970', first.mbid)
    assert_equal('1392', first.playcount)
    assert_equal('1', first.rank)
    assert_equal('http://www.last.fm/music/Taylor+Swift', first.url)
    assert_equal('http://userserve-ak.last.fm/serve/34/30883349.png', first.thumbnail)
    assert_equal('http://userserve-ak.last.fm/serve/64/30883349.png', first.image)
  end
  
  test 'should be able to get top albums' do
    assert_equal(50, @user.top_albums.size)
    first = @user.top_albums.first
    assert_equal('Dwight Yoakam', first.artist)
    assert_equal('0fb711af-c7ba-4bdc-b0b6-b8495fc0a590', first.artist_mbid)
    assert_equal('The Very Best of Dwight Yoakam', first.name)
    assert_equal('b6a051b4-1a1e-4c33-a1e5-0ea6e920a13f', first.mbid)
    assert_equal('560', first.playcount)
    assert_equal('1', first.rank)    
    assert_equal('http://www.last.fm/music/Dwight+Yoakam/The+Very+Best+of+Dwight+Yoakam', first.url)
    assert_equal('http://userserve-ak.last.fm/serve/34s/8725405.jpg', first.image(:small))
    assert_equal('http://userserve-ak.last.fm/serve/64s/8725405.jpg', first.image(:medium))
    assert_equal('http://userserve-ak.last.fm/serve/126/8725405.jpg', first.image(:large))
  end

  test 'should be able to get top tracks' do
    assert_equal(50, @user.top_tracks.size)
    first = @user.top_tracks.first
    assert_equal("Probably Wouldn't Be This Way", first.name)
    assert_equal('LeAnn Rimes', first.artist)
    assert_equal('9092d8e1-9b38-4372-a96d-000b8561a8bc', first.artist_mbid)
    assert_equal("", first.mbid)
    assert_equal('83', first.playcount)
    assert_equal('1', first.rank)
    assert_equal('http://www.last.fm/music/LeAnn+Rimes/_/Probably+Wouldn%27t+Be+This+Way', first.url)
  end

  test 'should be able to get top tags' do
    assert_equal(12, @user.top_tags.size)
    first = @user.top_tags.first
    assert_equal("country", first.name)
    assert_equal("7", first.count)
    assert_equal("http://www.last.fm/tag/country", first.url)
  end
  
  # not implemented
  test 'should be able to get top tags for artist' do
  end
  # not implemented
  test 'should be able to get top tags for album' do
  end
  # not implemented
  test 'should be able to get top tags for track' do
  end
  
  test 'should have friends' do
    assert_equal(17, @user.friends.size)
    first = @user.friends.first
    assert_equal('mayorcj', first.username)
    assert_equal('http://www.last.fm/user/mayorcj', first.url)
    assert_equal('http://userserve-ak.last.fm/serve/34/37841973.jpg', first.avatar)
  end
  
  test 'should have neighbours' do
    assert_equal(50, @user.neighbours.size)
    first = @user.neighbours.first
    assert_equal('AustinFarrellR', first.username)
    assert_equal('http://www.last.fm/user/AustinFarrellR', first.url)
    assert_equal('http://userserve-ak.last.fm/serve/34/24713961.jpg', first.avatar)
  end

  test 'should have recent tracks' do
    assert_equal(10, @user.recent_tracks.size)
    first = @user.recent_tracks.first
    assert_equal('Airstream Song', first.name)
    assert_equal('Miranda Lambert', first.artist)
    assert_equal('4eca1aa0-c79f-481b-af8a-4a2d6c41aa5c', first.artist_mbid)
    assert_equal('', first.mbid)
    assert_equal('4eca1aa0-c79f-481b-af8a-4a2d6c41aa5c', first.album_mbid)
    assert_equal('Revolution', first.album)
    assert_equal('http://www.last.fm/music/Miranda+Lambert/_/Airstream+Song', first.url)
    assert_equal(Time.mktime(2010, 6, 19, 17, 6, 00), first.date)
    assert_equal('1276967182', first.date_uts)
  end

  test 'should have recent loved tracks' do
    assert_equal(50, @user.recent_loved_tracks.size)
    first = @user.recent_loved_tracks.first
    assert_equal('Don\'t Stop Believin\' (Glee Cast Version)', first.name)
    assert_equal('Glee Cast', first.artist)
    assert_equal('50549203-9602-451c-b49f-ff031ba8635c', first.artist_mbid)
    assert_equal('', first.mbid)
    assert_equal('http://www.last.fm/music/Glee+Cast/_/Don%27t+Stop+Believin%27+%28Glee+Cast+Version%29', first.url)
    assert_equal(Time.mktime(2009, 5, 27, 14, 36, 00), first.date)
    assert_equal('1243434966', first.date_uts)
  end

  test 'should have recommendations is deprecated' do
    assert_equal(0, @user.recommendations.size)
  end
  
  test 'should have artist recommendations' do
    first = @user.recommended_artists("token").first
    assert_equal('Virginia Jetzt!', first.name)
    assert_equal('433d544f-d6c6-4c79-aefd-6f4c7918e5fe', first.mbid)
    assert_equal('http://www.last.fm/music/Virginia+Jetzt%21', first.url)
  end
  
  test 'should have charts' do
    assert_equal(229, @user.charts.size)
    first = @user.charts.first
    assert_equal(1134302403, first.from)
    assert_equal(1134907203, first.to)
  end
  
  test 'should have weekly artist chart' do
    chart = @user.weekly_artist_chart
    assert_equal(3, chart.size)
    first = chart.first
    assert_equal('Glee Cast', first.name)
    assert_equal('6e0ae159-8449-4262-bba5-18ec87fa529f', first.mbid)
    assert_equal('1', first.chartposition)
    assert_equal('45', first.playcount)
    assert_equal('http://www.last.fm/music/Glee+Cast', first.url)
  end
  
  test 'should have weekly artist chart for past weeks' do
    chart = @user.weekly_artist_chart(1138536002, 1139140802)
    assert_equal(33, chart.size)
    first = chart.first
    assert_equal('Jenny Lewis with The Watson Twins', first.name)
    assert_equal('4b179fe2-dfa5-40b1-b6db-b56dbc3b5f09', first.mbid)
    assert_equal('1', first.chartposition)
    assert_equal('48', first.playcount)
    assert_equal('http://www.last.fm/music/Jenny+Lewis+with+The+Watson+Twins', first.url)
  end
  
  test 'should have weekly album chart' do
    chart = @user.weekly_album_chart
    assert_equal(4, chart.size)
    first = chart.first
    assert_equal('Brad Mehldau', first.artist)
    assert_equal('b7723b3f-9a35-438d-bc42-8ad8b5e027ae', first.artist_mbid)
    assert_equal("Highway Rider", first.name)
    assert_equal('', first.mbid)
    assert_equal('1', first.chartposition)
    assert_equal('15', first.playcount)
    assert_equal('http://www.last.fm/music/Brad+Mehldau/Highway+Rider', first.url)
  end
  
  test 'should have weekly album chart for past weeks' do
    chart = @user.weekly_album_chart(1138536002, 1139140802)
    assert_equal(20, chart.size)
    first = chart.first
    assert_equal('Jewel', first.artist)
    assert_equal('abae8575-ec8a-4736-abc3-1ad5093a68aa', first.artist_mbid)
    assert_equal("0304", first.name)
    assert_equal('52b3f067-9d82-488c-9747-6d608d9b9486', first.mbid)
    assert_equal('1', first.chartposition)
    assert_equal('13', first.playcount)
    assert_equal('http://www.last.fm/music/Jewel/0304', first.url)
  end 
  
  test 'should have track album chart' do
    chart = @user.weekly_track_chart
    assert_equal(42, chart.size)
    first = chart.first
    assert_equal('Glee Cast', first.artist)
    assert_equal('3ac2a4a2-52b3-498b-bbc8-31443c68dfe0', first.artist_mbid)
    assert_equal('Gives You Hell (Glee Cast Version)', first.name)
    assert_equal('', first.mbid)
    assert_equal('1', first.chartposition)
    assert_equal('5', first.playcount)
    assert_equal('http://www.last.fm/music/+noredirect/Glee+Cast/_/Gives+You+Hell+%28Glee+Cast+Version%29', first.url)
  end

  test 'should have weekly track chart for past weeks' do
    chart = @user.weekly_track_chart(1138536002, 1139140802)
    assert_equal(88, chart.size)
    first = chart.first
    assert_equal('Natasha Bedingfield', first.artist)
    assert_equal('8b477559-946e-4ef2-9fe1-446cff8fdd79', first.artist_mbid)
    assert_equal('Unwritten', first.name)
    assert_equal('', first.mbid)
    assert_equal('1', first.chartposition)
    assert_equal('8', first.playcount)
    assert_equal('http://www.last.fm/music/Natasha+Bedingfield/_/Unwritten', first.url)
  end

  test 'should get recommendated events' do
    user = Rockstar::User.new('bodot')
    events = user.events("token")

    first = events.first
    assert_equal(7, events.size)
    assert_equal("Cityfestival (gamescom)", first.title)
    assert_equal(13, first.artists.size)
    assert_equal("2raumwohnung", first.artists.first)
    assert_equal(1, first.headliners.size)
    assert_equal("2raumwohnung", first.headliners.first)
    assert_equal(Time.local(2010, 8, 20, 17, 50, 1), first.start_date)
    assert_equal(Time.local(2010, 8, 22, 17, 50, 1), first.end_date)
    assert(first.description.length >= 814)
    assert_equal(200, first.attendance) 
    assert_equal(0, first.reviews)
    assert_equal("lastfm:event=1575046", first.tag)
    assert_equal("http://www.last.fm/festival/1575046+Cityfestival+%28gamescom%29", first.url)
    assert_equal("http://www.gamescom.de", first.website)
    assert_equal(false, first.cancelled)
    assert_equal(0, first.tickets.size)
    assert_equal(["indie", "german"], first.tags)
    assert_equal("http://userserve-ak.last.fm/serve/34/3608276.jpg",  first.images["small"])
    assert_equal("http://userserve-ak.last.fm/serve/64/3608276.jpg",  first.images["medium"])
    assert_equal("http://userserve-ak.last.fm/serve/126/3608276.jpg", first.images["large"])
    assert_equal("http://userserve-ak.last.fm/serve/252/3608276.jpg", first.images["extralarge"])
    
    assert_equal("Innenstadt", first.venue.name)

    assert_equal("Köln", first.venue.city.mb_chars)
    assert_equal("Germany", first.venue.country)
    assert_equal("Street", first.venue.street)
    assert_equal("12345", first.venue.postalcode)
    assert_equal("50.929442", first.venue.lat)
    assert_equal("6.961012", first.venue.long)
    assert_equal("http://www.last.fm/venue/8921690+Innenstadt", first.venue.url)
    assert_equal("http://example.com", first.venue.website)
    assert_equal("+49 110", first.venue.phonenumber)
    assert_equal("small",      first.venue.images["small"])
    assert_equal("medium",     first.venue.images["medium"])
    assert_equal("large",      first.venue.images["large"])
    assert_equal("extralarge", first.venue.images["extralarge"])

  end 

end
