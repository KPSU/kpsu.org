class ContentsController < ApplicationController
  layout 'alternative'
  # GET /contents
  # GET /contents.xml
  before_filter :is_staff, :only => ['new', 'edit', 'destroy', 'update', 'create', 'index']
  before_filter :no_listener, :only => ['new', 'edit', 'destroy', 'update', 'create']
  
  def index
    @downloads = Download.find(:all, :limit => 5, :order => "downloads.created_at DESC", :include => [:user, :program], :conditions => ['downloads.user_id IS NOT ? AND downloads.program_id IS NOT ? AND downloads.program_id > ?', nil, nil, 0])
    @rev = Review.order("created_at DESC").limit(5)
    @roles = current_user.roles
    @abilities = []
    @roles.each {|r| r.abilities.each { |a| @abilities << a }}
    Rails.logger.info @abilities
    @contents = []
    @abilities.each { |a| f = Content.find_by_title(a.title); if f then @contents << f end }
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @contents }
    end
  end
  # GET /contents/1
  # GET /contents/1.xml
  
  def view
    if params[:title] != nil && params[:title].size > 0
      @content = Content.find_by_title(params[:title])
      if @content.title.split(" ").size > 1
        @title = ""
        @content.title.split(" ").each do |u|
          if u.downcase == "kpsu"
            @title += "#{u.upcase}"
          else 
            @title += "#{u.capitalize} "
          end
        end
      else
        @title = @content.title.capitalize
      end
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @content }
      end
    else
      @content = Content.find(params[:id])
      @title = ""
      @content.title.split(" ").each do |u|
        logger.info u
        if u.downcase == "kpsu"
          @title += "#{u.upcase} "
        elsif u.chop.downcase == "kpsu"
          @title += "#{u.upcase} "
        else           
          @title += "#{u.capitalize} "
        end
      end
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @content }
      end
    end
    
  end
  
  def show

    @content = Content.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @content }
    end
  end

  # GET /contents/new
  # GET /contents/new.xml
  def new
    @sections = Section.all
    @content = Content.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @content }
    end
  end

  # GET /contents/1/edit
  def edit
    @sections = Section.all
    @content = Content.find(params[:id])
    respond_to do |format|
      format.js {render :partial => "edit"}
    end
  end

  # POST /contents
  # POST /contents.xml
  def create
    @content = Content.new(params[:content])
    @content.title = @content.title.downcase
    @content.section_id = Section.find_by_title(params[:section])
    respond_to do |format|
      if @content.save
        format.html { redirect_to(@content, :notice => 'Content was successfully created.') }
        format.xml  { render :xml => @content, :status => :created, :location => @content }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @content.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /contents/1
  # PUT /contents/1.xml
  def update
    @content = Content.find(params[:id])
    @content.title = @content.title.downcase
    @content.section_id = Section.find_by_title(params[:section])
    respond_to do |format|
      if @content.update_attributes(params[:content])
        format.html { redirect_to(@content, :notice => 'Content was successfully updated.') }
        format.js { render :partial => "saved.js"}
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @content.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /contents/1
  # DELETE /contents/1.xml
  def destroy
    @content = Content.find(params[:id])
    @content.destroy

    respond_to do |format|
      format.html { redirect_to(contents_url) }
      format.xml  { head :ok }
    end
  end
  
end
