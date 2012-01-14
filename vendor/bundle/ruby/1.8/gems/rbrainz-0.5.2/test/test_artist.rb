# -*- coding: utf-8 -*-
# $Id: test_artist.rb 258 2009-05-17 17:43:58Z phw $
#
# Author::    Philipp Wolfer (mailto:phw@rubyforge.org)
# Copyright:: Copyright (c) 2007-2009, Philipp Wolfer
# License::   RBrainz is free software distributed under a BSD style license.
#             See LICENSE[file:../LICENSE.html] for permissions.

require 'test_entity'
require 'test_rateable'
require 'test_relateable'
require 'test_taggable'

# Unit test for the Artist model.
class TestArtist < Test::Unit::TestCase

  def setup
    @tested_class = Model::Artist
    @invalid_entity_types = [:release, :track, :label]
    @release_groups = [Model::ReleaseGroup.new, Model::ReleaseGroup.new]
    @releases = [Model::Release.new, Model::Release.new]
    @aliases = [Model::Alias.new, Model::Alias.new]
  end

  def teardown
  end
  
  # Include the tests for Entity
  include TestEntity
  include TestRateable
  include TestRelateable
  include TestTaggable

  def test_new_artist
    artist = nil
    assert_nothing_raised {artist = Model::Artist.new}
    assert artist.is_a?(Model::Entity)
    
    mbid = Model::MBID.new('9d30e408-1559-448b-b491-2f8de1583ccf', artist.entity_type)
    assert_nothing_raised {artist = Model::Artist.new(
      mbid,
      Model::Artist::TYPE_GROUP,
      'The White Stripes',
      'White Stripes, The'
      )}
    assert_equal mbid, artist.id
    assert_equal Model::Artist::TYPE_GROUP, artist.type
    assert_equal 'The White Stripes', artist.name
    assert_equal 'White Stripes, The', artist.sort_name
  end
  
  def test_name
    artist = Model::Artist.new
    assert artist.name.nil?
    assert_nothing_raised {artist.name = 'Paradise Lost'}
    assert_equal 'Paradise Lost', artist.name
  end
  
  def test_sort_name
    artist = Model::Artist.new
    assert artist.sort_name.nil?
    assert_nothing_raised {artist.sort_name = 'Paradise Lost'}
    assert_equal 'Paradise Lost', artist.sort_name
  end
  
  def test_disambiguation
    artist = Model::Artist.new
    assert artist.disambiguation.nil?
    assert_nothing_raised {artist.disambiguation = 'Disambiguation comment'}
    assert_equal 'Disambiguation comment', artist.disambiguation
  end
  
  def test_unique_name
    artist = Model::Artist.new
    artist.name = 'Paradise Lost'
    artist.disambiguation = 'British metal / hard rock band'
    assert_equal 'Paradise Lost (British metal / hard rock band)', artist.unique_name
    assert_equal 'Paradise Lost (British metal / hard rock band)', artist.to_s
  end
  
  def test_type
    artist = Model::Artist.new
    assert artist.type.nil?
    assert_nothing_raised {artist.type = Model::Artist::TYPE_PERSON}
    assert_equal Model::Artist::TYPE_PERSON, artist.type
    assert_nothing_raised {artist.type = Model::Artist::TYPE_GROUP}
    assert_equal Model::Artist::TYPE_GROUP, artist.type
  end

  def test_begin_date
    artist = Model::Artist.new
    date = Model::IncompleteDate.new '1988-04-18'
    assert_nothing_raised {artist.begin_date}
    assert_equal nil, artist.begin_date
    assert_nothing_raised {artist.begin_date = date}
    assert_equal date, artist.begin_date
    
    # It should be able to supply a date as a string,
    # but Artist should convert it to an IncompleteDate.
    assert_nothing_raised {artist.begin_date = '1988-04-20'}
    assert_equal Model::IncompleteDate.new('1988-04-20'), artist.begin_date
  end

  def test_end_date
    artist = Model::Artist.new
    date = Model::IncompleteDate.new '1988-04-18'
    assert_nothing_raised {artist.end_date}
    assert_equal nil, artist.end_date
    assert_nothing_raised {artist.end_date = date}
    assert_equal date, artist.end_date
    
    # It should be able to supply a date as a string,
    # but Artist should convert it to an IncompleteDate.
    assert_nothing_raised {artist.end_date = '1988-04-20'}
    assert_equal Model::IncompleteDate.new('1988-04-20'), artist.end_date
  end

  def test_add_and_remove_release_groups
    artist = Model::Artist.new
    assert_equal 0, artist.release_groups.size
    assert_nothing_raised {artist.release_groups << @release_groups[0]}
    assert_equal 1, artist.release_groups.size
    assert_nothing_raised {artist.release_groups << @release_groups[1]}
    assert_equal 2, artist.release_groups.size
    
    assert_nothing_raised {artist.release_groups.delete @release_groups[1]}
    assert_equal 1, artist.release_groups.size
    assert_nothing_raised {artist.release_groups.delete @release_groups[0]}
    assert_equal 0, artist.release_groups.size
  end
  
  # Many releases can be added
  def test_add_and_remove_releases
    artist = Model::Artist.new
    assert_equal 0, artist.releases.size
    assert_nothing_raised {artist.releases << @releases[0]}
    assert_equal 1, artist.releases.size
    assert_nothing_raised {artist.releases << @releases[1]}
    assert_equal 2, artist.releases.size
    
    assert_nothing_raised {artist.releases.delete @releases[1]}
    assert_equal 1, artist.releases.size
    assert_nothing_raised {artist.releases.delete @releases[0]}
    assert_equal 0, artist.releases.size
  end
  
  # Many aliases can be added
  def test_add_and_remove_aliases
    artist = Model::Artist.new
    assert_equal 0, artist.aliases.size
    assert_nothing_raised {artist.aliases << @aliases[0]}
    assert_equal 1, artist.aliases.size
    assert_nothing_raised {artist.aliases << @aliases[1]}
    assert_equal 2, artist.aliases.size
    
    assert_nothing_raised {artist.aliases.delete @aliases[1]}
    assert_equal 1, artist.aliases.size
    assert_nothing_raised {artist.aliases.delete @aliases[0]}
    assert_equal 0, artist.aliases.size
  end
  
end
