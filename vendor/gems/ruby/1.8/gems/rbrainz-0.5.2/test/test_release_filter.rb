# -*- coding: utf-8 -*-
# $Id: test_release_filter.rb 264 2009-05-24 22:15:19Z phw $
#
# Author::    Philipp Wolfer (mailto:phw@rubyforge.org)
# Copyright:: Copyright (c) 2007, Philipp Wolfer
# License::   RBrainz is free software distributed under a BSD style license.
#             See LICENSE[file:../LICENSE.html] for permissions.

require 'test/unit'
require 'testing_helper'
require 'rbrainz'
include MusicBrainz

# Unit test for the ReleaseFilter class.
class TestReleaseFilter < Test::Unit::TestCase

  def setup
    @filter_hash = {
      :title        => 'Haven',
      :discid       => 'D5nZLROSPGvr75fj0C72YfowjiQ-',
      :artist       => 'Dark Tranquillity',
      :artistid     => '9d30e408-1559-448b-b491-2f8de1583ccf',
      :releasetypes => 'Album Official',
      :count        => 12,
      :date         => '2000-07-17',
      :asin         => 'B00004VVW9',
      :lang         => 'ENG',
      :script       => 'Latn',
      :cdstubs      => false,
      :limit        => 10,
      :offset       => 20,
      :query        => 'date:2000'
      }
  end

  def teardown
  end
  
  def test_filter
    filter = Webservice::ReleaseFilter.new(@filter_hash)
    filter_string = filter.to_s
    assert_not_equal '&', filter_string[0]
    
    result_hash = query_string_to_hash filter_string
    assert_equal @filter_hash[:title], result_hash['title'], filter_string
    assert_equal @filter_hash[:discid], result_hash['discid'], filter_string
    assert_equal @filter_hash[:artist], result_hash['artist'], filter_string
    assert_equal @filter_hash[:artistid], result_hash['artistid'], filter_string
    assert_equal @filter_hash[:releasetypes], result_hash['releasetypes'], filter_string
    assert_equal @filter_hash[:count].to_s, result_hash['count'], filter_string
    assert_equal @filter_hash[:date], result_hash['date'], filter_string
    assert_equal @filter_hash[:asin], result_hash['asin'], filter_string
    assert_equal @filter_hash[:lang], result_hash['lang'], filter_string
    assert_equal @filter_hash[:script], result_hash['script'], filter_string
    assert_equal 'no', result_hash['cdstubs'], filter_string
    assert_equal @filter_hash[:limit].to_s, result_hash['limit'], filter_string
    assert_equal @filter_hash[:offset].to_s, result_hash['offset'], filter_string
    assert_equal @filter_hash[:query].to_s, result_hash['query'], filter_string
  end
  
  def test_release_types_as_array
    filter = Webservice::ReleaseFilter.new(:releasetypes => [Model::Release::TYPE_ALBUM, 'Official'])
    filter_string = filter.to_s
    assert_not_equal '&', filter_string[0]
    
    result_hash = query_string_to_hash filter_string
    assert_equal 'Album Official', result_hash['releasetypes'], filter_string
  end
  
  def test_empty_filter
    filter = Webservice::ReleaseFilter.new({})
    assert_equal 'cdstubs=no', filter.to_s
  end
  
  def test_include_cdstubs
    filter = Webservice::ReleaseFilter.new({ :cdstubs => true })
    assert_equal 'cdstubs=yes', filter.to_s
  end
  
  def test_exclude_cdstubs
    filter = Webservice::ReleaseFilter.new({ :cdstubs => false })
    assert_equal 'cdstubs=no', filter.to_s
  end
  
end
