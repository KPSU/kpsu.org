class HandbookPagesController < ApplicationController
  # GET /handbook_pages
  # GET /handbook_pages.xml
  before_filter :is_staff, :only => [:new, :edit, :destroy, :create, :update]
  before_filter :no_listener, :only => ['new', 'edit', 'destroy', 'update', 'create']
  
  layout 'auxiliary'
  def index
    @handbook_pages = HandbookPage.all

    respond_to do |format|
      format.html # index.html.erb
      format.js { render :partial => "index" }
      format.xml  { render :xml => @handbook_pages }
    end
  end

  # GET /handbook_pages/1
  # GET /handbook_pages/1.xml
  def show
    @handbook_page = HandbookPage.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.js { render :partial => "show" }
      format.xml  { render :xml => @handbook_page }
    end
  end

  # GET /handbook_pages/new
  # GET /handbook_pages/new.xml
  def new
    @handbook_page = HandbookPage.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @handbook_page }
    end
  end

  # GET /handbook_pages/1/edit
  def edit
    @handbook_page = HandbookPage.find(params[:id])
  end

  # POST /handbook_pages
  # POST /handbook_pages.xml
  def create
    @handbook_page = HandbookPage.new(params[:handbook_page])

    respond_to do |format|
      if @handbook_page.save
        format.html { redirect_to(@handbook_page, :notice => 'Handbook page was successfully created.') }
        format.xml  { render :xml => @handbook_page, :status => :created, :location => @handbook_page }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @handbook_page.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /handbook_pages/1
  # PUT /handbook_pages/1.xml
  def update
    @handbook_page = HandbookPage.find(params[:id])

    respond_to do |format|
      if @handbook_page.update_attributes(params[:handbook_page])
        format.html { redirect_to(@handbook_page, :notice => 'Handbook page was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @handbook_page.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /handbook_pages/1
  # DELETE /handbook_pages/1.xml
  def destroy
    @handbook_page = HandbookPage.find(params[:id])
    @handbook_page.destroy

    respond_to do |format|
      format.html { redirect_to(handbook_pages_url) }
      format.xml  { head :ok }
    end
  end
end
