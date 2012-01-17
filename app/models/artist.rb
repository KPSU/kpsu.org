class Artist < ActiveRecord::Base
  
  has_many :albums
  has_many :tracks
  has_many :artist_playlists
  has_many :playlists, :through => :artist_playlists
  has_many :featured_artists
  has_many :views, :as => :viewable
  
  validates_uniqueness_of :name
  validates_presence_of :name
  
  def to_param
    name.gsub(/[\.]|[\/]/, "_").gsub(/[\s]/, "-").downcase
  end

  def self.find(*args)
    unless (args[0].class == Symbol) || (args[0].to_i > 0)
      @name = args[0].gsub(/[\-]/, " ").downcase
      find(:first, :conditions => ['name LIKE ?', @name])
    else
      super
    end

  end
  
end
