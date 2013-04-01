class ReviewsController < ApplicationController
  # GET /reviews
  # GET /reviews.xml
  layout 'alternative'
  before_filter :require_user, :only => ['new', 'edit', 'destroy', 'update', 'create']
  before_filter :no_listener, :only => ['new', 'edit', 'destroy', 'update', 'create']
  
  autocomplete :artist, :name, :full => false
  autocomplete :album, :name, :full => false, :display_value => :playlist_autocomplete
  autocomplete :label, :name, :full => false, :display_value => :label_autocomplete
  
  def index
    @reviews = Review.paginate(:page => params[:page], :per_page => 5, :order => 'id DESC')
    #@reviews = WillPaginate::Collection.create(:all, :page => params[:page], :per_page => params[:per_page], :order => 'id DESC')
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @reviews }
    end
  end

  # GET /reviews/1
  # GET /reviews/1.xml
  def show
    @color = ["blue", "green", "magenta", "purple", "yellow", "orange", "red"].shuffle[0]
    @review = Review.find(params[:id])
    #@amazon = album_cover_fetch(:artist => @review.artist.name, :album => @review.album.name)
    @genres = Genre.all
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @review }
    end
  end

  # GET /reviews/new
  # GET /reviews/new.xml
  def new
    @review = Review.new
    @genres = Genre.all

    respond_to do |format|
      format.html # new.html.erb
      format.js { render :partial => "new" }
      format.xml  { render :xml => @review }
    end
  end

  # GET /reviews/1/edit
  def edit
    @genres = Genre.all
    
    @review = Review.find(params[:id])
    
    respond_to do |format|
      format.html # new.html.erb
      format.js { render :partial => "edit" }
      format.xml  { render :xml => @review }
    end
  end

  # POST /reviews
  # POST /reviews.xml
  def create

    @title = params[:review][:title]
    @review = Review.new()
    @artist = Artist.find_by_name(params[:artist])
      if @artist == nil
        @a = Artist.new
        @a.name = params[:artist]
        @a.save
        @artist = @a
      end
    @album = Album.find(:first, :conditions => ['artist_id = ? AND name = ?', @artist.id, params[:album] ])
    Rails.logger.info @album.to_json
    if @album == nil
      @al = Album.new
      @al.artist = @artist
      @al.name = params[:album]
      @al.save
      @album = @al
    end
    if params[:attachment] != nil
      logger.info "why?"
      logger.info params[:attachment][:title]
      @ass = Asset.new(:item => params[:asset])
      @ass.user = current_user
      @ass.title = params[:attachment][:asset][:title]
      @ass.description = params[:attachment][:asset][:description]
      @ass.save
      @asset = @ass
      Rails.logger.info @ass.errors.full_messages.each { |e| puts e }
    end
    if params[:review][:label]
      @label = Label.find_by_name(params[:label])
      if @label == nil
        @label = Label.new
        @label.name = params[:label]
        @label.save
      end
    end
    @body = params[:review][:body]
    @genre = Genre.find(params[:genres])
    @review.artist = @artist
    @review.title = @title
    @review.album = @album
    @review.user = current_user
    @review.genre = @genre
    @review.body = @body
    @review.label = @label
    respond_to do |format|
      if @review.save
        if @asset
          @asset.review_id = @review.id
          @asset.save
        end
        format.html { redirect_to(@review, :notice => 'Review was successfully created.') }
        format.js { render :partial => "saved.js" }
        format.xml  { render :xml => @review, :status => :created, :location => @review }
      else
        format.html { render :action => "new" }
        format.js { render :partial => "error.js" }
        format.xml  { render :xml => @review.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /reviews/1
  # PUT /reviews/1.xml
  def update
    @review = Review.find(params[:id])
    @artist = Artist.find_by_name(params[:artist])
    @album = Album.find_by_artist_id_and_name(@artist.id, params[:album])
    @genre = Genre.find(params[:genres])
    @review.genre = @genre
    @review.artist = @artist
    @review.album = @album
    @review.body = params[:review][:body]
    @asset = ""
    if params[:attachment]
      @a = Asset.new(:item => params[:asset])
      logger.info "hello"
      
      @a.user = current_user
      @a.title = params[:attachment][:asset][:title]
      @a.description = params[:attachment][:asset][:description]
      @a.save
      @asset = @a
      logger.info @a.errors.full_messages.each { |e| puts e }
      
    end
    respond_to do |format|
      if @review.save
        if @asset
          @asset.review_id = @review.id
          @asset.save
        end
        format.html { redirect_to(@review, :notice => 'Review was successfully created.') }
        format.js { render :partial => "saved.js" }
        format.xml  { render :xml => @review, :status => :created, :location => @review }
      else
        format.html { render :action => "edit" }
        format.js { render :partial => "error.js" }
        format.xml  { render :xml => @review.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.xml
  def destroy
    @review = Review.find(params[:id])
    if @review.assets
      @review.assets.each do |a|
        a.destroy
      end
    end
    @review.destroy
    respond_to do |format|
      format.html { redirect_to(reviews_url) }
      format.xml  { head :ok }
    end
  end
end
