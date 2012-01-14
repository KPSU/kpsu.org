require File.expand_path('../../test_helper.rb', __FILE__)

class TestArtist < Test::Unit::TestCase

  def setup
    @artist = Rockstar::Artist.new('Metallica')
  end
  
  test 'should require name' do
    assert_raises(ArgumentError) { Rockstar::Artist.new('') }
  end
  
  test "should know it's name" do
    assert_equal('Metallica', @artist.name)
  end

  test 'should be able to find similar artists' do
    assert_equal(["Megadeth", "Slayer", "Iron Maiden", "Pantera", "Anthrax", "Sepultura"], @artist.similar.collect(&:name)[0..5])
    first = @artist.similar.first
    assert_equal('Megadeth', first.name)
    assert_equal('a9044915-8be3-4c7e-b11f-9e2d2ea0a91e', first.mbid)
    assert_equal('1', first.match)
    assert_equal('http://www.last.fm/music/Megadeth', first.url)
    assert_equal('http://userserve-ak.last.fm/serve/34/598154.jpg', first.thumbnail)
    assert_equal('http://userserve-ak.last.fm/serve/64/598154.jpg', first.image)
    assert_equal('http://userserve-ak.last.fm/serve/126/598154.jpg', first.images['large'])
    assert_equal('yes', first.streamable)
  end
  
  test 'should be able to find top fans' do
    assert_equal(["yIIyIIyIIy", "eliteveritas", "BrandonUCD", "Mithrandir93"], @artist.top_fans.collect(&:username)[0..3])
    first = @artist.top_fans.first
    assert_equal('yIIyIIyIIy', first.username)
    assert_equal('http://www.last.fm/user/yIIyIIyIIy', first.url)
    assert_equal('http://userserve-ak.last.fm/serve/34/40197285.jpg', first.avatar)
    assert_equal('http://userserve-ak.last.fm/serve/34/40197285.jpg', first.images['small'])
    assert_equal('http://userserve-ak.last.fm/serve/64/40197285.jpg', first.images['medium'])
    assert_equal('http://userserve-ak.last.fm/serve/126/40197285.jpg', first.images['large'])
    assert_equal('http://userserve-ak.last.fm/serve/252/40197285.jpg', first.images['extralarge'])
    assert_equal('707560000', first.weight)
  end
  
  test 'should be able to find top tracks' do
    assert_equal(['Nothing Else Matters', 'Enter Sandman', 'One', 'Master Of Puppets'], @artist.top_tracks.collect(&:name)[0..3])
    first = @artist.top_tracks.first
    assert_equal('Nothing Else Matters', first.name)
    assert_equal('', first.mbid)
    assert_equal('http://www.last.fm/music/Metallica/_/Nothing+Else+Matters', first.url)
  end
  
  test 'should be able to find top albums' do
    assert_equal(["Master Of Puppets", "Death Magnetic", "Ride The Lightning"], @artist.top_albums.collect(&:name)[0..2])
    first = @artist.top_albums.first
    assert_equal('Master Of Puppets', first.name)
    assert_equal('fed37cfc-2a6d-4569-9ac0-501a7c7598eb', first.mbid)
    assert_equal('http://www.last.fm/music/Metallica/Master+Of+Puppets', first.url)
    assert_equal('http://userserve-ak.last.fm/serve/34s/8622967.jpg', first.image(:small))
    assert_equal('http://userserve-ak.last.fm/serve/64s/8622967.jpg', first.image(:medium))
    assert_equal('http://userserve-ak.last.fm/serve/126/8622967.jpg', first.image(:large))    
  end
  
  test 'should be able to find top tags' do
    assert_equal(['thrash metal', 'metal', 'heavy metal'], @artist.top_tags.collect(&:name)[0..2])
    first = @artist.top_tags.first
    assert_equal('thrash metal', first.name)
    assert_equal('100', first.count)
    assert_equal('http://www.last.fm/tag/thrash%20metal', first.url)
  end
end
