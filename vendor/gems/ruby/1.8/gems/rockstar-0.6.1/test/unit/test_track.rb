require File.expand_path('../../test_helper.rb', __FILE__)

class TestTrack < Test::Unit::TestCase

  def setup
    @track = Rockstar::Track.new('Carrie Underwood', 'Before He Cheats')
  end
  
  test 'should require the artist name' do
    assert_raises(ArgumentError) { Rockstar::Track.new('', 'Before He Cheats') }
  end
  
  test 'should require the track name' do
    assert_raises(ArgumentError) { Rockstar::Track.new('Carrie Underwood', '') }
  end
  
  test "should know the artist" do
    assert_equal('Carrie Underwood', @track.artist)
  end
  
  test 'should know the name' do
    assert_equal('Before He Cheats', @track.name)
  end

  test 'should be able to load track info' do
    @track.load_info
    assert_equal('http://www.last.fm/music/Carrie+Underwood/_/Before+He+Cheats', @track.url)
    assert_equal('1040848',  @track.playcount)
    assert_match(/named the 2007 Single of the Year by the Country Music Association/, @track.summary)
  end

  test 'should be able to request detailed album info on initialize' do
    track = Rockstar::Track.new('Carrie Underwood', 'Before He Cheats', :include_info => true)
    assert_equal('Carrie Underwood', track.artist)
    assert_equal('http://www.last.fm/music/Carrie+Underwood/_/Before+He+Cheats', track.url)
    assert_equal('1040848', track.playcount)
    assert_match(/named the 2007 Single of the Year by the Country Music Association/, track.summary)
  end
  
  test 'should have albums' do
    assert_equal(1, @track.albums.size)
    assert_equal('Some Hearts', @track.albums.first.name)
    assert_equal('http://www.last.fm/music/Carrie+Underwood/Some+Hearts', @track.albums.first.url)
    assert_equal('a33b9822-9f09-4e19-9d6e-e05af85c727b', @track.albums.first.mbid)
  end

  test 'should have fans' do
    assert_equal(50, @track.fans.size)
    assert_equal('chelseaf89', @track.fans.first.username)
    assert_equal('http://www.last.fm/user/chelseaf89', @track.fans.first.url)
    assert_equal('http://userserve-ak.last.fm/serve/34/41303325.jpg', @track.fans.first.avatar)
    assert_equal('5000000', @track.fans.first.weight)
  end
  
  test 'should have top tags' do
    assert_equal(100, @track.tags.size)
    assert_equal('country', @track.tags.first.name)
    assert_equal('100', @track.tags.first.count)
    assert_equal('http://www.last.fm/tag/country', @track.tags.first.url)
  end
  
  test 'can love tracks' do
    assert_equal('ok', @track.love("tag"))  
  end

  test 'raise missing parameter error in scrobble' do
    assert_raises(ArgumentError) { Rockstar::Track.scrobble() }
  end

  test 'can scrobble tracks' do
    assert_equal('ok', @track.scrobble(Time.utc(2010,10,10,8,10), 'tag'))
  end

  test 'raise missing parameter error in update now playing' do
    assert_raises(ArgumentError) { Rockstar::Track.updateNowPlaying() }
  end

  test 'can send current playing track' do
    assert_equal('ok', @track.updateNowPlaying(Time.utc(2010,10,10,8,10), 'tag'))
  end

end
