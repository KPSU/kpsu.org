class PlaylistsController < ApplicationController
  layout 'alternative'
  before_filter :require_user, :only => ['new', 'edit', 'index', 'search', 'destroy', 'update', 'create']
  before_filter :has_profile_filled_out
  before_filter :no_listener, :only => ['new', 'edit', 'destroy', 'index', 'update', 'create']
  before_filter :increment_visit, :only => ['show']
  autocomplete :artist, :name, :full => false
  autocomplete :program, :title, :full => true
  autocomplete :album, :name, :full => false, :display_value => :playlist_autocomplete
  autocomplete :track, :title, :full => false, :display_value => :track_autocomplete
  autocomplete :label, :name, :full => false, :display_value => :label_autocomplete
  # GET /playlists
  # GET /playlists.xml
  def index
    @inpage = params[:inpage]
    @playlists = current_user.playlists.order("created_at DESC").paginate(:page => params[:page], :per_page => 25)
    respond_to do |format|
      format.js { render :partial => "index" }
    end
  end

  # GET /playlists/1
  # GET /playlists/1.xml
  def show
    @playlist = Playlist.find(params[:id])
    if @playlist != nil
      @tracks = @playlist.playlist_items.all
      @tracks.sort! { |x,y| x.position <=> y.position }
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @playlist }
      end
    else
      four_oh_four_error
    end
  end
  
  def search
    if params[:track_search]
      
      @artists = []
      @albums = []
      @tracks = []
      
      if params[:artist_search]
        @results = Artist.name_like(params[:search])
        @aa = @artists.map{|a| a.id }
        @artists = Track.find_all_by_artist_id(@aa) rescue nil
      end
      
      if params[:album_search]
        
        @albums = Album.name_like(params[:search])
        @aa = @albums.map{|a| a.id }
        @tracks = Track.find_all_by_album_id(@aa) rescue nil
      end 
      
      if params[:search_type] == "tracks"
        @tracks = Track.title_like(params[:search]) rescue nil
      else
      end
      
      if @tracks && @tracks.size > 0
        respond_to do |format|
          format.js { render :partial => "track_search.js.erb" }
        end
      else
        respond_to do |format|
          format.js { render :partial => "track_error.js.erb" }
        end
      end
    
    else
    
      if params[:search_type] == "artist"
        @artists = Artist.name_like(params[:search])
        @aa = @artists.map{|a| a.id }
        @tracks = Track.find_all_by_artist_id(@aa) rescue nil
      elsif params[:search_type] == "albums"
        @albums = Album.title_like(params[:search])
        @aa = @albums.map{|a| a.id }
        @tracks = Track.find_all_by_album_id(@aa) rescue nil
      elsif params[:search_type] == "tracks"
        @tracks = Track.title_like(params[:search]) rescue nil
      else
      end
      @type = params[:search_type].pluralize
      if @tracks && @tracks.size > 0
        respond_to do |format|
          format.js { render :partial => "search.js.erb" }
        end
      else
        respond_to do |format|
          format.js { render :partial => "search_error.js.erb" }
        end
      end
    end
  end
  
  def export
    # Give the path of the temp file to the zip outputstream, it won't try to open it as an archive.
    @playlists = current_user.playlists.all

    csv_string = FasterCSV.generate do |csv|
      # header row
      csv << ["playlist title", "artist", "album", "track name", "label"]

      # data rows
      @playlists.each do |playlist|
        @playlist.tracks.each do |track|
          csv << ["#{track.playlist.title rescue nil}", "#{track.artist.name rescue nil}", "#{track.album.name rescue nil}", "#{track.title rescue nil}", "#{track.album.label.name rescue nil}"]
        end
      end
    end

    # send it to the browsah
    send_data csv_string,
              :type => 'text/csv; charset=iso-8859-1; header=present',
              :disposition => "attachment; filename=users.csv"
  end
  
  # GET /playlists/new
  # GET /playlists/new.xml
  def new
    @inpage = params[:inpage]
    @playlist = Playlist.new
    @psetup = Program.all
    @programs = []
    @psetup.each do |p|
      if p.event
        @programs << p
      end
    end
    @downloads = []
    @dsetup = Download.all
    @dsetup.each do |d|
      if d.program_id == current_user.programs.first.id
        @downloads << d
      end
    end
    @downloads.sort! {|y,x| x.title.to_i <=> y.title.to_i}
    @currently_playing_option = Download.find_by_title("Currently Playing")
    @downloads << @currently_playing_option
    respond_to do |format|
      format.js { render :partial => "new" }
      format.xml  { render :xml => @playlist }
    end
  end

  # GET /playlists/1/edit
  def edit
    @psetup = Program.all
    @programs = []
    @psetup.each do |p|
      if p.event
        @programs << p
      end
    end
    @downloads = []
    @dsetup = Download.all
    @dsetup.each do |d|
      if d.program_id == current_user.programs.first.id
        @downloads << d
      end
    end
    @downloads.sort! {|y,x| x.title.to_i <=> y.title.to_i}

    /above i am replicating the iteration right before it/
    /error may lie in being careless here; someone double check/
    @playlist = Playlist.find(params[:id])
    @this_download = Download.find(@playlist.download_id)
    @pi = @playlist.playlist_items.sort! { |a,b| a.position <=> b.position }
    respond_to do |format|
      format.js { render :partial => "edit" }
      format.xml  { render :xml => @playlist }
    end
  end

  # POST /playlists
  # POST /playlists.xml
  def create
    @i = 0
    @title = params[:playlist][:title]
    @description = params[:playlist][:description]
    @tmp_tracks = params[:tracks].split(",")
    @program = Program.find(params[:programs])
    if params[:downloads]
      #@download_id = Download.find(params[:downloads]).id
      unless params[:downloads] = 18049
        @download = Download.find(params[:downloads])
        @download.update_attributes(:playlist_id => @playlist.id)  
        @download.save
        @download.reload
        @playlist = Playlist.new(:title => @title, :program => @program, :description => @description, :user_id => current_user.id, :download_id => @download.id)
        @playlist.save
        @playlist.reload
      end
      if params[:downloads] = 18049
        @playlist = Playlist.new(:title => @title, :program => @program, :description => @description, :user_id => current_user.id, :download_id => Download.last.id + 1)
        @playlist.save
        @playlist.reload
        @download = Download.new(:title => "Archive_rake Changes Me", :playlist_id => @playlist.id)
        @download.save
        @download.reload
      end
    end
    #The above asks if the user chose those "Currently Playing" token - in this case "2000-01-01 00:00:00"
    #If it does (i.e. if params[:downloads] = 18049) then it creates a Download called "Archive_rake Changes Me"
    #archive.rake looks for a download called "Archive_rake Changes Me" each time it runs
    #If it finds it, it just puts the playlist ID on the Download it makes anyway, and erases "Archive_rake Changes Me"
    #Thus, that download is just a placeholder token for the playlist ID when the playlist is made in the middle of a show.
  



    #here i am attempting to extract the variable (downloads) taken in from the form (on the view.)
    #i belive an error may lie in the local variable @download taking the entire object instead of just the string
    #then, below, when we initialize a playlist object below, it's taking a bad format for that attribute
    #@playlist = Playlist.new(:title => @title, :program => @program, :description => @description, :user_id => current_user.id)
   

    

    @i = 0
    @tmp_tracks.each do |track|
      @i += 1
      @track = Track.find(track)
      @pi = PlaylistItem.new
      @pi.track = @track
      @pi.playlist = @playlist
      @pi.position = @i
      @pi.save
    end
    respond_to do |format|
      format.js { render :partial => "saved.js.erb" }
    end
  end

  # PUT /playlists/1
  # PUT /playlists/1.xml
  def update
    @ii = 0
    @playlist = Playlist.find(params[:id])
    @program = Program.find(params[:programs])
    if params[:downloads]
      @download = Download.find(params[:downloads])
      @download.update_attributes(:playlist_id => @playlist.id)
      @download.save
      @download.reload
    end
    @playlist.update_attributes(:download_id => @download.id)
    @tmp_tracks = params[:tracks].split(",")
    @playlist.playlist_items.each do |pi|
        pi.destroy
    end
    Rails.logger.info(@tmp_tracks.length)
    @tmp_tracks.each do |track|
      @ii += 1
      @track = Track.find(track)
      @pi = PlaylistItem.new
      @pi.track = @track
      @pi.playlist = @playlist
      @pi.position = @ii
      @pi.save
    end
    @playlist.save
    @playlist.reload

    
    respond_to do |format|
      format.js { render :partial => "saved.js.erb" }
    end
  end

  # DELETE /playlists/1
  # DELETE /playlists/1.xml
  def destroy
    @playlist = Playlist.find(params[:id])
    @playlist.playlist_items
    @playlist.destroy
    @msg = "Success!"
    respond_to do |format|
      format.html { redirect_to(playlists_url) }
      format.json { render :json => @msg }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def increment_visit
      @p = Playlist.find(params[:id])
      if @p
        @v = View.new
        @v.viewable = @p
        @v.user_agent = request.user_agent
        @v.save
      end
  end
  
end
