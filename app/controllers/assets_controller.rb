class AssetsController < ApplicationController

  layout 'alternative'
  caches_action :index, :cache_path => Proc.new { |c| c.request.url }, :expires_in => 4.hours
  before_filter :require_user, :only => ['new', 'edit', 'destroy', 'update', 'create']
  before_filter :no_listener, :only => ['new', 'edit', 'destroy', 'update', 'create']
  
  def index
    # Fleakr.api_key = "8d3e3baaf9deb4ec5ea13f32bbba2be9"
    # @flickr = Fleakr.user('KPSU')
    # @page = params[:page].to_i ||= 1
    
  end
  
  def flickr
    expire_action(:index)
  end

  def show
    # Fleakr.api_key = "8d3e3baaf9deb4ec5ea13f32bbba2be9"
    # @album = Fleakr::Objects::Set.find_by_id(params[:id])
  end

  # GET /assets/new
  # GET /assets/new.xml
  def new
    @asset = Asset.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @asset }
    end
  end

  # GET /assets/1/edit
  def edit
    @asset = Asset.find(params[:id])
  end

  # POST /assets
  # POST /assets.xml
  def create
    @asset = Asset.new(params[:asset])

    respond_to do |format|
      if @asset.save
        format.html { redirect_to(@asset, :notice => 'Asset was successfully created.') }
        format.xml  { render :xml => @asset, :status => :created, :location => @asset }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @asset.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /assets/1
  # PUT /assets/1.xml
  def update
    @asset = Asset.find(params[:id])

    respond_to do |format|
      if @asset.update_attributes(params[:asset])
        format.html { redirect_to(@asset, :notice => 'Asset was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @asset.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /assets/1
  # DELETE /assets/1.xml
  def destroy
    @asset = Asset.find(params[:id])
    @asset.destroy

    respond_to do |format|
      format.html { redirect_to(assets_url) }
      format.xml  { head :ok }
    end
  end
end
