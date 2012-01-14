require 'brainz'
require "em-synchrony"
require "em-synchrony/fiber_iterator"
require "em-synchrony/em-http"

class ArtistsController < ApplicationController
  layout 'alternative'
  before_filter :require_user, :only => ['new', 'edit', 'destroy', 'update', 'create']
  before_filter :no_listener, :only => ['new', 'edit', 'destroy', 'update', 'create']
  before_filter :increment_visit, :only => ['show']
  caches_action :show
  def index
    
    @views = View.where("viewable_type = ?", "Artist").limit(10)
    @artists = @views.map{|v| v.viewable }
    @newest = Artist.where("brainz_id IS NOT ?", nil).order("created_at DESC").limit(10)
    @random = Artist.where("brainz_id IS NOT ?", nil).sample(10)
    
  end

  def show
    @brainz = BrainzAPI.new
    @artist = Artist.find(params[:id])
    unless @artist.brainz_id
      @brainz.add_brainz_to_artist(@artist.id)
      @artist.reload
    end
    @p = []
    @t = []
    @a = []
    @track_titles = []
    @album_titles = []
    @artist.tracks.each do |t|
      t.playlists.each do |p|
        unless @p.include?(p)
          @p << p
        end
      end
      
      if @artist.albums.all.size > 0
        @artist.albums.each do |a|
          a.tracks.each do |s|
            unless @track_titles.include?(s.title)
              @track_titles << s.title
              @t << s     
            end
          end
        end
      else
        @t << t
      end
    end
    @artist.albums.each do |a|
      unless @album_titles.include?(a.name)
        @album_titles << a.name
        @a << a
      end
    end
    @amazon = album_cover_fetch(:artist => @artist.name, :album => @artist.albums.first.name)
    @playlists = @p.sort{|x,y| y.created_at <=> x.created_at }
    @tracks = @t
    @a_brainz = @brainz.lookup_artist(@artist.brainz_id)
    if @a_brainz && @tracks
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @artist }
      end
    else
      respond_to do |format|
        format.html {render :action => "no_artist"}
      end
    end
  end
  
  def edit
    
  end
  
  def new
    
  end
  
  def create
    
  end
  
  def destroy
    
  end
  
  private
  
  def increment_visit
      @a = Artist.find(params[:id])
      if @a
        @v = View.new
        @v.viewable = @a
        @v.user_agent = request.user_agent
        @v.save
      end
  end
  
end
