class TracksController < ApplicationController
  
  before_filter :require_user
  before_filter :no_listener
  
  def index
  end

  def edit
  end

  def new
  end
  
  def create
    @label = Label.find_or_create_by_name(params[:label])
    if @label.new_record?
      @label.save
    end
    @label.reload
    @artist = Artist.find_or_create_by_name(params[:artist])
    if @artist.new_record?
      @artist.save
    end
    @artist.reload
    @album = Album.find_or_create_by_name_and_artist_id(params[:album], @artist.id)
    if @album.new_record?
      @album.artist = @artist
      if @label
        @album.label = @label
      end
      @album.save
    end
    @album.reload
    @track = Track.find_or_create_by_title_and_artist_id_and_album_id(params[:track], @artist.id, @album.id)
    if @track.new_record?
      @track.album = @album
      @track.artist = @artist
    end
    if @track.save
      respond_to do |format|
        format.js { render :partial => "saved.js.erb" }
      end
    else
      respond_to do |format|
        format.js { render :partial => "error.js.erb" }
      end
    end
  end

end
