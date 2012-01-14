class MessagesController < ApplicationController
  
  before_filter :require_user
  
  layout  'auxiliary'
  
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @chatrooms }
    end
  end
  
  def build_response(messsage)
    @response = Hash.new
    @response['id'] = @message.id
    @response['avatar'] = current_user.avatar.url(:square_thumb_tiny)
    @response['body'] = @message.message
    @response['name'] = "#{@sender.f_name} #{@sender.l_name}"
    if @sender.dj_name
      @response['dj'] = true
      @response['dj_name'] = @sender.dj_name
    end
    @response['recipient-chat-id'] = @message.recipient.chatroom_id
    @response['sender-chat-id'] = @message.sender.chatroom_id
    return @response
  end
  
  def send_message
    
    Rails.logger.info(params[:recipient_chat_id])
    Rails.logger.info(params[:sender_chat_id])
    
    @recipient = User.find_by_chatroom_id(params[:recipient_chat_id])
    @sender = User.find_by_chatroom_id(params[:sender_chat_id])
    @message = Message.new    
    @message.message = params[:body]
    @message.recipient = @recipient
    @message.sender = @sender
    @message.recipient_room_id = @recipient.chatroom_id
    @message.sender_room_id = @sender.chatroom_id
    if @message.save
      @response = build_response(@message)
      @response['color'] = params[:color]
      @response2 = @response
      Juggernaut.publish(@recipient.chatroom_id, @response.to_json)
      Juggernaut.publish(@sender.chatroom_id, @response2.to_json)
      respond_to do |format|
        format.html # index.html.erb
        format.js { render :json => "message: 'ok'" }
        format.xml  { render :xml => @chatrooms }
      end
    else
      respond_to do |format|
       format.js { render :partial => "error.js.erb" } 
      end
    end
  end
  
  def show
    @message = Message.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @message }
    end
  end

  # GET /messages/new
  # GET /messages/new.xml
  def new
    @message = Message.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @message }
    end
  end


  def create
    @message = Message.new(params[:message])

    respond_to do |format|
      if @message.save
        format.html { redirect_to(@message, :notice => 'Message was successfully created.') }
        format.xml  { render :xml => @message, :status => :created, :location => @message }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /messages/1
  # PUT /messages/1.xml
  def update
    @message = Message.find(params[:id])

    respond_to do |format|
      if @message.update_attributes(params[:message])
        format.html { redirect_to(@message, :notice => 'Message was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.xml
  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    respond_to do |format|
      format.html { redirect_to(messages_url) }
      format.xml  { head :ok }
    end
  end
  
  
  
end
