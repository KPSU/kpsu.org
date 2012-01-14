# -*- coding: utf-8 -*-
# $Id: track.rb 254 2009-05-13 20:04:36Z phw $
#
# Author::    Philipp Wolfer (mailto:phw@rubyforge.org)
# Copyright:: Copyright (c) 2007, Nigel Graham, Philipp Wolfer
# License::   RBrainz is free software distributed under a BSD style license.
#             See LICENSE[file:../LICENSE.html] for permissions.

require 'rbrainz/model/entity'
require 'rbrainz/model/isrc'
require 'rbrainz/model/rateable'
require 'rbrainz/model/relateable'
require 'rbrainz/model/taggable'

module MusicBrainz
  module Model

    # A track in the MusicBrainz DB.
    # 
    # See:: http://musicbrainz.org/doc/Track.
    class Track < Entity
    
      include Rateable
      include Relateable
      include Taggable
      
      # See Entity::ENTITY_TYPE.
      ENTITY_TYPE = :track # :nodoc:
      
      # The track's title.
      attr_accessor :title
      
      # The duration in milliseconds.
      attr_accessor :duration
      
      # The track's main artist.
      attr_accessor :artist
      
      # The list of associated PUIDs.           
      attr_reader :puids
      
      # The list of associated ISRCs.           
      attr_reader :isrcs
      
      # The releases on which this track appears.
      attr_reader :releases
      
      def initialize(id=nil, title=nil)
        super id
        self.title = title
        @puids     = Collection.new
        @isrcs     = Collection.new
        @releases  = Collection.new
      end
      
      # Returns the string representation for this track.
      # 
      # Returns #title converted into a string.
      def to_s
        title.to_s
      end
      
    end

  end
end
