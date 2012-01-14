module PlaylistsHelper


  def show_label(id)
      if id
        @album = Album.find(id)
        @label = @album.label
        if @label
        return @label.name
        else
        end
      end
      
  end

end
