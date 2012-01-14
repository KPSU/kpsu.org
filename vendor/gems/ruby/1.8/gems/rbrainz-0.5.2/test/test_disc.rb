# -*- coding: utf-8 -*-
# $Id: test_disc.rb 254 2009-05-13 20:04:36Z phw $
#
# Author::    Philipp Wolfer (mailto:phw@rubyforge.org)
# Copyright:: Copyright (c) 2007, Philipp Wolfer
# License::   RBrainz is free software distributed under a BSD style license.
#             See LICENSE[file:../LICENSE.html] for permissions.

require 'test/unit'
require 'rbrainz/model'
include MusicBrainz

# Unit test for the Disc model.
class TestDisc < Test::Unit::TestCase

  def setup
  end

  def teardown
  end
  
  def test_new_disc
    disc = nil
    assert_nothing_raised {disc = Model::Disc.new}
    assert_nothing_raised {disc = Model::Disc.new('Tit3F0Do_sZ_7NbfM_1vlEbF0wo-')}
    assert_equal 'Tit3F0Do_sZ_7NbfM_1vlEbF0wo-', disc.id
  end
  
  def test_id
    disc = Model::Disc.new
    assert disc.id.nil?
    assert_nothing_raised {disc.id = 'Tit3F0Do_sZ_7NbfM_1vlEbF0wo-'}
    assert_equal 'Tit3F0Do_sZ_7NbfM_1vlEbF0wo-', disc.id
    assert_equal 'Tit3F0Do_sZ_7NbfM_1vlEbF0wo-', disc.to_s
  end

  def test_sectors
    disc = Model::Disc.new
    assert disc.sectors.nil?
    assert_nothing_raised {disc.sectors = 264432}
    assert_equal 264432, disc.sectors
  end
  
end
