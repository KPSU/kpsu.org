class PlaylistItem < ActiveRecord::Base
  belongs_to :playlist
  belongs_to :track
  
  
  
  def create_playlist_artist
      @p = self.playlist
      @a = self.artist
      @pa_exists = PlaylistArtist.find(:all, :conditions => ['playlist_id = ? and artist_id = ?', @p.id, @a.id])
      if @pa_exists != nil && @pa_exists.size > 0
        @pa = PlaylistArtist.new
        @pa.artist = @a
        @pa.playlist = @p
        @pa.save
      end
  end
  
end
