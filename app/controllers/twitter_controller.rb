class TwitterController < ApplicationController
  before_filter :require_user, :except => [:callback, :kpsu_recent_tweets] 
  before_filter :no_listener, :except => [:callback, :kpsu_recent_tweets, :tweet]
  respond_to :json, :js, :html

  def kpsu_twitter_token
    Rails.application.config.kpsu_twitter_token
  end
  
  def kpsu_twitter_secret
    Rails.application.config.kpsu_twitter_secret
  end
  
  def twitter_consumer_secret
    Rails.application.config.twitter_consumer_secret
  end
  
  def twitter_consumer_key
    Rails.application.config.twitter_consumer_key
  end

  def index    
    if current_user.access_tokens.count >= 1
    @timeline = TwitterOAuth::Client.new(
        :consumer_key => twitter_consumer_key,
        :consumer_secret => twitter_consumer_secret,
        :token => current_user.access_tokens.first.token, 
        :secret => current_user.access_tokens.first.secret
    ).home_timeline
    
    @timeline = @timeline.to_json
    
    else
      @t = 1
    end  	
  end
  
  def kpsu_recent_tweets
      @timeline = twitter.search('#kpsu OR #radrev')
      #@radiorevival = twitter.search('#radrev')
      #@radiorevival = @radiorevival.to_json
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
            :consumer_key => twitter_consumer_key,
            :consumer_secret => twitter_consumer_secret,
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
