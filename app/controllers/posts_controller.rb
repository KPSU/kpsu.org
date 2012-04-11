class PostsController < ApplicationController
  layout :choose_layout
  before_filter :require_user, :only => ['new', 'edit', 'destroy', 'update', 'create']
  before_filter :has_profile_filled_out
  before_filter :no_listener, :only => ['new', 'edit', 'destroy', 'update', 'create']
  before_filter :increment_visit, :only => ['show']

  caches_action :index, 
                :cache_path => proc {|controller| controller.params.merge({:only_path => true}) },
                :expires_in => 10.minutes
  # GET /posts
  # GET /posts.xml
  
  def index
    @user_session = UserSession.new

    unless params[:page]
    @downloads = Download.find(:all, :limit => 5, :order => "downloads.created_at DESC", :include => [:user, :program], :conditions => ['downloads.user_id IS NOT ? AND downloads.program_id IS NOT ? AND downloads.program_id > ?', nil, nil, 0])
    @start = Date.strptime("12/31/2010 01:01:01", "%m/%d/%Y %H:%M").to_time
    @rev = Review.order("created_at DESC").limit(5)
    @post = Post.where(:content_type_id => 1).order("created_at DESC").limit(2)

    if params[:blog]
      @posts = Post.paginate(:all, :order => "created_at DESC", :conditions => ['content_type_id = ? AND created_at > ?', 1, @start], :per_page => 7, :page => params[:page])
    elsif params[:review]
      @posts = Post.paginate(:all, :order => "created_at DESC", :conditions => ['content_type_id = ? AND created_at > ?', 1, @start], :per_page => 7, :page => params[:page])
    else 
      @posts = Post.where('posts.created_at > ?', @start).includes(:user).order("posts.created_at DESC").paginate(:per_page => 7, :page => params[:page])
    end
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @posts }
    end
    else

    end
  end
  
  def pageless_posts
    
    # Time in Ruby 1.9.x requires you use (in order):
    # =>  day/month/year
    # you know, how the rest of the world does it

    @start = Time.parse("31/12/2010 01:01:01")
    @posts = Post.where('created_at >= ?', @start).order("created_at DESC").paginate(:per_page => 7, :page => params[:page].to_i)
    respond_to do |format|
      format.js { render :partial => "index" }
    end
  end
  
  def user_posts
    @posts = Post.order('created_at DESC').where(:user_id => current_user.id)
    respond_to do |format|
      format.html 
      format.xml  { render :xml => @posts }
    end
  end
  
  # GET /posts/1
  # GET /posts/1.xml
  def show
    
    
    @posts = Post.find(:all, :order => "created_at DESC", :conditions => ['content_type_id = ?', 2], :limit => 5)
    @blogs = Post.find(:all, :order => "created_at DESC", :conditions => ['content_type_id = ?', 1], :limit => 5)
    # add content type
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    @post = Post.new
    @content_type = ContentType.all
    respond_to do |format|
      format.html # new.html.erb
      format.js { render :partial => "new" }
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @content_type = ContentType.all
    
    @post = Post.find(params[:id])
    respond_to do |format|
      format.html
      format.js {render :partial => "edit"}
    end
  end

  # POST /posts
  # POST /posts.xml
  def create
    # add content type
    @content_type = ContentType.find(params[:content_type])
    @p = params[:post]
    @post = Post.new
    @post.title = @p[:title]
    @post.body = @p[:body]
    @asset = ""
    if @p[:asset]
      @a = Asset.new(:item => @p[:asset])
      @a.user = current_user
      @a.title = params[:attachment][:asset][:title]
      @a.description = params[:attachment][:asset][:description]
      @a.save
      @asset = @a      
    end
    
    @post.attachment_style = @p[:attachment_style]
    
    @post.content_type = @content_type
    @post.user = current_user
    respond_to do |format|
      if @post.save
        if @asset != ""
          @asset.post_id = @post.id
          @asset.save
        end
        format.html { redirect_to(@post, :notice => 'Post was successfully created.') }
        format.js { render :partial => "saved.js" }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.js { render :partial => "error.js" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
    @post = Post.find(params[:id])
    @p = params[:post]
    @content_type = ContentType.find(params[:content_type])
    @post.title = @p[:title]
    @post.body = @p[:body]
    @asset = ""
    if @p[:asset]
      @a = Asset.new(:item => @p[:asset])
      logger.info "hello"
      
      logger.info @p[:asset]
      @a.user = current_user
      @a.title = params[:attachment][:asset][:title]
      @a.description = params[:attachment][:asset][:description]
      @a.save
      @asset = @a
      logger.info @a.errors.full_messages.each { |e| puts e }
      
    end
    @post.attachment_style = @p[:attachment_style]
    @post.content_type = @content_type
    
    respond_to do |format|
      if @post.save
        if @asset != ""
          @asset.post_id = @post.id
          @asset.save
        end
        format.html { redirect_to(@post, :notice => 'Post was successfully updated!') }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(posts_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  def choose_layout
    if ['show', 'new', 'edit', 'user_posts'].include? action_name
      'alternative'
    else
      'application'
    end
  end
  
  def increment_visit
      @p = Post.find(params[:id])
      if @p
        @v = View.new
        @v.viewable = @p
        @v.user_agent = request.user_agent
        @v.save
      end
  end
  
end
