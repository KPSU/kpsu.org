class Track < ActiveRecord::Base
  belongs_to :artist
  belongs_to :album
  has_many :playlist_items
  has_many :playlists, :through => :playlist_items
  
  def track_autocomplete
    @artist = Artist.find(self.artist)
    "#{self.title} // #{@artist.name}"
  end
  
end
