require File.expand_path('../../test_helper.rb', __FILE__)

class TestGeo < Test::Unit::TestCase
  
  test "should get events in london" do
    geo = Rockstar::Geo.new
    events = geo.events({:location => 'london'})
  
    assert_equal(10, events.size)
    assert_equal("Basement Scam", events.first.title)
    assert_equal("Buffalo Bar", events.first.venue.name)
    assert_equal("London", events.first.venue.city)
  end

  test "get cities for a country" do
    geo = Rockstar::Geo.new

    metros = geo.metros("germany")
    assert_equal(10, metros.size)
    assert_equal("Bremen", metros.first.name)
    assert_equal("Germany", metros.first.country)
  end
  

end
