# -*- coding: utf-8 -*-
# $Id: test_track_filter.rb 254 2009-05-13 20:04:36Z phw $
#
# Author::    Philipp Wolfer (mailto:phw@rubyforge.org)
# Copyright:: Copyright (c) 2007, Philipp Wolfer
# License::   RBrainz is free software distributed under a BSD style license.
#             See LICENSE[file:../LICENSE.html] for permissions.

require 'test/unit'
require 'testing_helper'
require 'rbrainz'
include MusicBrainz

# Unit test for the TrackFilter class.
class TestTrackFilter < Test::Unit::TestCase

  def setup
    @filter_hash = {
      :title       => 'The Wonders at Your Feet',
      :artist      => 'Dark Tranquillity',
      :release     => 'Haven',
      :duration    => 1811000,
      :tracknum    => 1,
      :artistid    => '9d30e408-1559-448b-b491-2f8de1583ccf',
      :releaseid   => '0cc5ec17-f52e-42d5-abe8-7b3cdd251e21',
      :puid        => '26d1355d-60b7-0de2-7a57-d01d7ee9e8be',
      :count       => 12,
      :releasetype => 'Album',
      :limit       => 10,
      :offset      => 20,
      :query       => 'arid: 9d30e408-1559-448b-b491-2f8de1583ccf'
      }
  end

  def teardown
  end
  
  def test_filter
    filter = Webservice::TrackFilter.new(@filter_hash)
    filter_string = filter.to_s
    assert_not_equal '&', filter_string[0]
    
    result_hash = query_string_to_hash filter_string
    assert_equal @filter_hash[:title], result_hash['title'], filter_string
    assert_equal @filter_hash[:artist], result_hash['artist'], filter_string
    assert_equal @filter_hash[:release], result_hash['release'], filter_string
    assert_equal @filter_hash[:duration].to_s, result_hash['duration'], filter_string
    assert_equal @filter_hash[:tracknum].to_s, result_hash['tracknum'], filter_string
    assert_equal @filter_hash[:artistid], result_hash['artistid'], filter_string
    assert_equal @filter_hash[:releaseid], result_hash['releaseid'], filter_string
    assert_equal @filter_hash[:puid], result_hash['puid'], filter_string
    assert_equal @filter_hash[:count].to_s, result_hash['count'], filter_string
    assert_equal @filter_hash[:releasetype], result_hash['releasetype'], filter_string
    assert_equal @filter_hash[:limit].to_s, result_hash['limit'], filter_string
    assert_equal @filter_hash[:offset].to_s, result_hash['offset'], filter_string
    assert_equal @filter_hash[:query].to_s, result_hash['query'], filter_string
  end
  
  def test_release_type_as_constant
    filter = Webservice::TrackFilter.new(:releasetype => Model::Release::TYPE_ALBUM)
    filter_string = filter.to_s
    assert_not_equal '&', filter_string[0]
    
    result_hash = query_string_to_hash filter_string
    assert_equal 'Album', result_hash['releasetype'], filter_string
  end
  
  def test_empty_filter
    filter = Webservice::TrackFilter.new({})
    assert_equal '', filter.to_s
  end
  
end
