class Album < ActiveRecord::Base
  belongs_to :artist
  belongs_to :label
  has_many :tracks
  
  validates_uniqueness_of :name, :scope => :artist_id
  
  
  def playlist_autocomplete
    @artist = Artist.find(self.artist)
    "#{self.name} // #{@artist.name}"
  end
end
