require File.expand_path('../../test_helper.rb', __FILE__)

class TestTag < Test::Unit::TestCase

  def setup
    @tag = Rockstar::Tag.new('rock')
  end
  
  test 'should be able to find the top tags for the entire system' do
    assert_equal(250, Rockstar::Tag.top_tags.size)
    assert_equal('rock', Rockstar::Tag.top_tags.first.name)
    assert_equal('2920270', Rockstar::Tag.top_tags.first.count)
    assert_equal('http://www.last.fm/tag/rock', Rockstar::Tag.top_tags.first.url)
  end
  
  test 'should require name' do
    assert_raise(ArgumentError) { Rockstar::Tag.new('') }
  end
  
  test 'should have name' do
    assert_equal('rock', @tag.name)
  end
  
  test 'should be able to find top artists for a tag' do
    assert_equal(50, @tag.top_artists.size)
    assert_equal('The Beatles', @tag.top_artists.first.name)
    assert_equal('yes', @tag.top_artists.first.streamable)
    assert_equal('b10bbbfc-cf9e-42e0-be17-e2c3e1d2600d', @tag.top_artists.first.mbid)
    assert_equal('http://www.last.fm/music/The+Beatles', @tag.top_artists.first.url)
    assert_equal('http://userserve-ak.last.fm/serve/34/4069917.jpg', @tag.top_artists.first.thumbnail)
    assert_equal('http://userserve-ak.last.fm/serve/64/4069917.jpg', @tag.top_artists.first.image)
  end
  
  test 'should be able to find top albums for a tag' do
    assert_equal(50, @tag.top_albums.size)
    assert_equal('Stadium Arcadium', @tag.top_albums.first.name)
    assert_equal('Red Hot Chili Peppers', @tag.top_albums.first.artist)
    assert_equal('8bfac288-ccc5-448d-9573-c33ea2aa5c30', @tag.top_albums.first.artist_mbid)
    assert_equal('http://www.last.fm/music/Red+Hot+Chili+Peppers/Stadium+Arcadium', @tag.top_albums.first.url)
    assert_equal('http://userserve-ak.last.fm/serve/34s/8810061.jpg', @tag.top_albums.first.image(:small))
    assert_equal('http://userserve-ak.last.fm/serve/64s/8810061.jpg', @tag.top_albums.first.image(:medium))
    assert_equal('http://userserve-ak.last.fm/serve/126/8810061.jpg', @tag.top_albums.first.image(:large))
  end
  
  test 'should be able to find top tracks for a tag' do
    assert_equal(50, @tag.top_tracks.size)
    first = @tag.top_tracks.first
    assert_equal('Californication', first.name)
    assert_equal('yes', first.streamable)
    assert_equal('Red Hot Chili Peppers', first.artist)
    assert_equal('8bfac288-ccc5-448d-9573-c33ea2aa5c30', first.artist_mbid)
    assert_equal('http://www.last.fm/music/Red+Hot+Chili+Peppers/_/Californication', first.url)
    assert_equal('http://userserve-ak.last.fm/serve/34s/42739473.png', first.thumbnail)
    assert_equal('http://userserve-ak.last.fm/serve/64s/42739473.png', first.image)
  end

end
