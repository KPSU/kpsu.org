class CatalogsController < ApplicationController
  # GET /catalogs
  # GET /catalogs.xml
  layout 'auxiliary'
  before_filter :require_user 
  before_filter :no_listener
  
  def index

    if params[:alphabetical]
      @catalogs = Catalog.paginate(:all, :order => "artist ASC", :page => params[:page], :conditions => [ 'artist LIKE ?', "#{params[:alphabetical]}%" ])

    else
      @catalogs = Catalog.paginate(:order => "number DESC", :page => params[:page])
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @catalogs }
    end
  end

  def search

    if params[:catalog][:album].size > 0 && params[:catalog][:artist].size > 0
      @catalogs = Catalog.album_like(params[:catalog][:album]).artist_like(params[:catalog][:artist]).paginate(:page => params[:page])
    elsif params[:catalog][:album].size > 0
      
      @catalogs = Catalog.album_like(params[:catalog][:album]).paginate(:page => params[:page])
    elsif params[:catalog][:artist].size > 0 
      
      @catalogs = Catalog.artist_like(params[:catalog][:artist]).paginate(:page => params[:page])
    end
    
  end
  # GET /catalogs/1
  # GET /catalogs/1.xml
  def show
    @catalog = Catalog.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @catalog }
    end
  end

  # GET /catalogs/new
  # GET /catalogs/new.xml
  def new
    @catalog = Catalog.new
    @last = Catalog.find(:first, :order => "number DESC")
    @n = @last.number.to_i + 1
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @catalog }
      format.js { render :partial => "new" }
    end
  end

  # GET /catalogs/1/edit
  def edit
    @catalog = Catalog.find(params[:id])
  end

  # POST /catalogs
  # POST /catalogs.xml
  def create
    @catalog = Catalog.new(params[:catalog])
    @last = Catalog.find(:first, :order => "number DESC")
    @n = @last.number.to_i + 1
    @catalog.number = @n
    respond_to do |format|
      if @catalog.save
        format.html { redirect_to(@catalog, :notice => 'Catalog was successfully created.') }
        format.xml  { render :xml => @catalog, :status => :created, :location => @catalog }
        format.js { render :partial => "saved" }
      else
        format.html { render :action => "new" }
        format.js { render :partial => "error" }
        format.xml  { render :xml => @catalog.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /catalogs/1
  # PUT /catalogs/1.xml
  def update
    @catalog = Catalog.find(params[:id])

    respond_to do |format|
      if @catalog.update_attributes(params[:catalog])
        format.html { redirect_to(@catalog, :notice => 'Catalog was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @catalog.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /catalogs/1
  # DELETE /catalogs/1.xml
  def destroy
    @catalog = Catalog.find(params[:id])
    @catalog.destroy

    respond_to do |format|
      format.html { redirect_to(catalogs_url) }
      format.xml  { head :ok }
    end
  end
end
