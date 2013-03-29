require 'amazon/aws'
require 'amazon/aws/search'
include Amazon::AWS
include Amazon::AWS::Search

class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user_session, :current_user
  rescue_from ActiveRecord::RecordNotFound, :with => :four_oh_four_error
  rescue_from ActionController::RoutingError, :with => :four_oh_four_error

  def four_oh_four_error
    render :template => "site/four_oh_four", :status => :not_found
  end

  private

  
  def days_in_month(month)
    (Date.new(Time.now.year,12,31).to_date<<(12-month)).day
  end
    
  def lookup_album_art(release)
    @release = release
    rg = ResponseGroup.new( 'Large' )
    req = Request.new
    il = ItemLookup.new( 'ASIN', { 'ItemId' => @release.asin,
                                    'MerchantId' => 'Amazon' } )
    begin
      @req = req.search( il, rg, 1 )
      @medium = @req.item_lookup_response.items.item.first.medium_image.url.to_s
      @large = @req.item_lookup_response.items.item.first.large_image.url.to_s 
      @image = {}
      @image[:small] = @medium
      @image[:large] = @large
    rescue Exception => e
      Rails.logger.error(e)      
      @image = nil
    end
    return @image                          
  end
    
  def large_album_cover_fetch(song)
    artist, album, track = [song[:artist], song[:album], song[:track]]
    rg = ResponseGroup.new( 'Large' )
    req = Request.new
    il = ItemSearch.new( 'Music', { 'Artist' => artist,
                                    'Title' => album } )
    begin
      @req = req.search( il, rg, 1 )
      @image = @req.item_search_response.items.item.first.large_image.url 
    rescue Exception => e
      @image = nil
    end
    return @image
  end
  
  def album_cover_fetch(song)
    artist, album, track = [song[:artist], song[:album], song[:track]]
    rg = ResponseGroup.new( 'Large' )
    req = Request.new
    il = ItemSearch.new( 'Music', { 'Artist' => artist,
                                    'Title' => album } )
    begin
      @req = req.search( il, rg, 1 )
      @image = @req.item_search_response.items.item.first.medium_image.url 
    rescue
      @image = nil
    end
    return @image
  end
  
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
  
  def twitter_client
    client = TwitterOAuth::Client.new(
    :consumer_key => twitter_consumer_key,
    :consumer_secret => twitter_consumer_secret
    )
  end
  
  def twitter
    client = TwitterOAuth::Client.new(
        :consumer_key => twitter_consumer_key,
        :consumer_secret => twitter_consumer_secret,
        :token => kpsu_twitter_token,
        :secret => kpsu_twitter_secret
    )
  end
  
  def twitter_login
    client = TwitterOAuth::Client.new(
      :consumer_key => twitter_consumer_key,
      :consumer_secret => twitter_consumer_secret
    )
    request_token = client.request_token(:oauth_callback => "http://kpsu.org/twitter/callback")
    session[:request_token] = request_token.token
    session[:request_token_secret] = request_token.secret
    redirect_to request_token.authorize_url.gsub('authorize', 'authenticate')
  end

  def current_user
    if defined?(@current_user) && !@current_user.nil?
      return @current_user 
    end
    @current_user = current_user_session && current_user_session.user
  end

  def current_user_session
    if defined?(@current_user_session) && !@current_user_session.nil?
      return @current_user_session 
    end
    @current_user_session = UserSession.find
  end

  
  def require_user
    unless current_user
      store_location
      flash[:notice] = "You must be logged in to access this page"
      redirect_to("/login")
      return false
    end
  end
  
  def is_staff
    unless current_user && current_user.staff
      store_location
      flash[:notice] = "You are not authenticated to access this page."
      redirect_to("/")
      return false
    end
  end
  
  def is_admin
    unless current_user.admin
      store_location
      flash[:notice] = "You are not authenticated to access this page."
      redirect_to("/")
      return false
    end
  end
  
  def require_no_user
    if current_user
      store_location
      flash[:notice] = "You must be logged out to access this page"
      redirect_to("/home")
      return false
    end
  end
  
  def no_listener
    if current_user
      if current_user.listener == true
        store_location
        flash[:notice] = "Aw shucks! Seems like you got a bit turned around, we've redirected back to the listener home."
        redirect_to(listener_path)
        return false
      end
    else
      redirect_to(login_path)
    end
  end
  
  def has_profile_filled_out
    if current_user && current_user.listener == false
      @has_pic = current_user.avatar.exists?
      @has_phone = current_user.phone?
      if @has_phone == true
        if current_user.phone.length < 7
          @has_phone = false
          @bullshit = true
        end
      end
      @has_about = ""
      if current_user.about == "This DJ hasn't filled out any information yet, hastle 'em about it!" 
            @has_about = false
          else
            @has_about = true 
      end
      if @has_pic == false || @has_about == false || @has_phone == false
        @msg = "To continue using KPSU please complete the following: <br/><br/>"
        if @has_about == false
          @msg += "Fill in your about section <br/>"
        end
        if @has_pic == false
          @msg += "Add a profile picture"
        end
        if @has_phone == false
          unless @bullshit == true
            @msg += "Please enter a valid phone number. Entering an incorrect one may result in a strike."
          else
            @msg += "Please enter a valid phone number. Entering an incorrect one may result in a strike."
            #was: @msg += "No really... You have to in your phone number. The KPSU staff has been notified."
          end
        end
        flash[:notice] = @msg
        @str = "/users/#{current_user.id}/edit"
        if request.xhr?
          @title = "Edit Profile"
          @user = current_user
          respond_to do |format|
            format.js { render :partial => "users/form" }
           end
        else
          redirect_to(dashboard_path(:anchor => @str))
        end
      end
    end
  end

  def store_location
    session[:return_to] = request.request_uri
  end
  
  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
  
end
