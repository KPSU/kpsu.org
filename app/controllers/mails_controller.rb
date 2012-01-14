class MailsController < ApplicationController
  # GET /mails
  # GET /mails.xml
  before_filter :require_user, :only => ['new', 'edit', 'destroy', 'update', 'create']
  before_filter :no_listener, :only => ['new', 'edit', 'destroy', 'update', 'create']
  
  def index
    @messages = (params[:folder] != 'sent') ? current_user.mails_in : current_user.mails_out
    @folder = params[:folder]
  end
  
  def show
    @message = Mail.find(params[:id])
    @user = User.find(@message.user_id)
  end

  def new
    @message = Mail.new
    @target = User.find(params[:user_target])
  end
  
  def edit
    @message = Mail.find(params[:id])
    @subject = @message.subject.sub(/^(Re: )?/, "Re: ")
    @target = User.find(@message.user_id)
  end
  
  def create
    @message = Mail.new(:user => current_user, :user_target => User.find(params[:user_target]), :subject => params[:subject], :body => params[:body])
    @message.save ? redirect_to(inbox_path) : render(:action => 'new', :user_targer => params[:user_target])
  end
  
  def update
    @message = Mail.find(params[:id])
    @message.toggle!(:recipient_deleted) ? redirect_to(inbox_path) : redirect_to(:action => 'show', :id => params[:id])
  end
  
  def destroy
    @message = Mail.find(params[:id])
    if @message.user_id == current_user.id
      @message.update_attribute("author_deleted", true)
    elsif @message.user_id_target == current_user.id
      @message.update_attribute("recipient_deleted", true)
    elsif @message.user_id == current_user.id && @message.user_id_target == current_user.id
      @message.update_attributes("recipient_deleted" => true, "author_deleted" => true)
    end
    redirect_to inbox_path
  end
  
end
