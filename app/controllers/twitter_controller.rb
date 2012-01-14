class TwitterController < ApplicationController
  before_filter :require_user, :except => [:callback, :kpsu_recent_tweets] 
  before_filter :no_listener, :except => [:callback, :kpsu_recent_tweets, :tweet]
  respond_to :json, :js, :html
  def index    
    if current_user.access_tokens.count >= 1
    @timeline = TwitterOAuth::Client.new(
        :consumer_key => 'GRpxk6zjTKk3o7wTuXiSw',
        :consumer_secret => 'q2yX19uuy2izSHKKcunNEMjk1BCGjnEeRg0JCCMF18',
        :token => current_user.access_tokens.first.token, 
        :secret => current_user.access_tokens.first.secret
    ).home_timeline
    
    @timeline = @timeline.to_json
    
    else
      @t = 1
    end  	
  end
  
  def kpsu_recent_tweets
      @timeline = twitter.search('#kpsu')
      @timeline = @timeline.to_json
      respond_with(@timeline)
  end
  
  def tweet
    if current_user
      @tweet = Tweet.new(:body => params[:status_update])
      @tweet.user = current_user
      @tweeted = twitter.update(params[:status_update])
      @tweet.tid = @tweeted['id']
      if @tweet.save
        respond_to do |format|
          format.js { render :partial => "tweeted.js" }
        end
      else
        respond_to do |format|
          format.js { render :partial => "layouts/problem.js" }
        end
      end
    end
  end
  
  def callback
    request_token = twitter_client.request_token()
    access_token = twitter_client.authorize(
      session[:request_token],
      session[:request_token_secret],
      :oauth_verifier => params[:oauth_verifier]
    )
    if access_token
      if current_user
        client = TwitterOAuth::Client.new(
            :consumer_key => 'GRpxk6zjTKk3o7wTuXiSw',
            :consumer_secret => 'q2yX19uuy2izSHKKcunNEMjk1BCGjnEeRg0JCCMF18',
            :token => access_token.token, 
            :secret => access_token.secret
        )
        @access_token = AccessToken.new
        @access_token.secret = access_token.secret
        @access_token.token = access_token.token
        @access_token.user_id = current_user.id
        if @access_token.save
          redirect_to('/twitter/')
        else
          redirecto_to(root_path)
        end
      elsif @token = AccessToken.find_by_token(access_token.token)
        @user_session = UserSession.new(@token.user)
        if @user_session.save
          redirect_to('/home')
        else
          redirect_to('/')
        end
      else
        @user = User.new
        @user.password = Array.new(12) { (rand(122-97) + 97).chr }.join
        @user.password_confirmation = @user.password
        @user.email = Array.new(12) { (rand(122-97) + 97).chr }.join + "@user.fauxtobox.com"
        if @user.save
          @access_token = AccessToken.new
          @access_token.secret = access_token.secret
          @access_token.token = access_token.token
          @access_token.user_id = @user.id
          if @access_token.save
            redirect_to('/home')
          else
          end
        else
        end
      end   
    else
    end
  end
  
  private
  
end
