class CommentsController < ApplicationController
  
  before_filter :require_user, :only => ['new', 'edit', 'destroy', 'update', 'create']
  layout 'auxiliary'
  
  # GET /comments
  # GET /comments.xml
  def index
    if params[:type]
      if params[:type] == "post"
        @comments = Comment.order('created_at DESC').where("post_id = ?", params[:id])
      elsif params[:type] == "program"
        @comments = Comment.order('created_at DESC').where("program_id = ?", params[:id])
      elsif params[:type] == "profile"
        @comments = Comment.order('created_at DESC').where("profile_id = ?", params[:id])
      elsif params[:type] == "playlist"
        @comments = Comment.order('created_at DESC').where("playlist_id = ?", params[:id])
      end
    end
    if @comments
      respond_to do |format|
        format.html # index.html.erb
        format.json { render :partial => "comments/index.json" }
        format.xml  { render :xml => @comments }
      end
    else
      respond_to do |format|
        @msg = "No comments! Damn. You're gonna have to write one yourself!"
        format.html # index.html.erb
        format.json { render :error => @msg, :status => 403 }
        format.xml  { render :xml => @comments }
      end
    end
  end

  # GET /comments/1
  # GET /comments/1.xml
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.xml
  def new
    @comment = Comment.new

    respond_to do |format|
      format.html { render :partial => "form"}
      format.xml  { render :xml => @comment }
    end
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # POST /comments
  # POST /comments.xml
  def create
    @comment = Comment.new(params[:comment])
    @comment.title = params[:title]
    @comment.body = params[:comment][:body]
    @type = params[:type]
    if @type == "post"
      @comment.post_id = params[:comment_parent_id]
    end
    if @type == "program"
      @comment.program_id = params[:comment_parent_id]
    end
    if @type == "profile"
      @comment.profile_id = params[:comment_parent_id]
      @comment.recipient_id = params[:comment_parent_id]
    end
    if @type == "playlist"
      @comment.playlist_id = params[:comment_parent_id]
    end
    @comment.user = current_user
    respond_to do |format|
      if  @comment.save
        format.html { redirect_to(@comment, :notice => 'Comment was successfully created.') }
        format.json { render :json => @comment.to_json(:include => { :user => { :only => [:f_name, :l_name]}}) }
        format.xml  { render :xml => @comment, :status => :created, :location => @comment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.xml
  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to(@comment, :notice => 'Comment was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.xml
  def destroy
    @comment = Comment.find(params[:id])
    if @comment.user == current_user
      @comment.destroy
      flash[:notice] = "Successfully destroyed!"
      @msg = flash[:notice]
    else
      flash[:notice] = "Something went wicked wrong!"
    end

    respond_to do |format|
      format.html { render :json => @msg }
      format.json { render :json => @msg }
      format.xml  { head :ok }
    end
  end
end
