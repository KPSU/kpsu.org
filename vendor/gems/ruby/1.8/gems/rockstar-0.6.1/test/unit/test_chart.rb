require File.expand_path('../../test_helper.rb', __FILE__)

class TestChart < Test::Unit::TestCase

  def setup
    @chart = Rockstar::Chart.new('1108296002', '1108900802')
  end
  
  test 'should require from' do
    assert_raise(ArgumentError) { Rockstar::Chart.new('', '1108900802') }
  end
  
  test 'should require to' do
    assert_raise(ArgumentError) { Rockstar::Chart.new('1108296002', '') }
  end
  
  test 'should be able to parse to and from that are unix timestamp strings' do
    chart = Rockstar::Chart.new('1108296002', '1108900802')
    assert_equal(1108296002, chart.from)
    assert_equal(1108900802, chart.to)
  end
  
  test 'should be able to parse to and from that are unix timestamp fixnums' do
    chart = Rockstar::Chart.new(1108296002, 1108900802)
    assert_equal(1108296002, chart.from)
    assert_equal(1108900802, chart.to)
  end
  
  test 'should be able to parse to and from that are times' do
    chart = Rockstar::Chart.new(Time.at(1108296002), Time.at(1108900802))
    assert_equal(1108296002, chart.from)
    assert_equal(1108900802, chart.to)
  end

end
