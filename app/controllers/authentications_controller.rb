class AuthenticationsController < ApplicationController
  
  def index
  end

  def create
    omniauth = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    if authentication
      flash[:notice] = "Signed in successfully."
      UserSession.create(authentication.user, true)
      initialize_chatroom
      
      redirect_back_or_default dashboard_path
    elsif current_user
      current_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
      flash[:notice] = "Authentication successful."
      initialize_chatroom
      
      redirect_back_or_default dashboard_path
    else
      user = User.new
      user.apply_omniauth(omniauth)
      newemail = ""
      chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
      newpass = ""
      1.upto(6) { |i| newpass << chars[rand(chars.size-1)] }
      1.upto(5) { |i| newemail << chars[rand(chars.size-1)] }
      
      if omniauth['provider'] == "facebook"
        user.email = omniauth['user_info']['email']
        user.image_url = omniauth['user_info']['image']
      else
        user.email = newemail + "@comments.kpsu.org"
      end
      
      if omniauth['provider'] == "twitter"
        user.image_url = omniauth['user_info']['image']
      end
      
      user.password = newpass
      user.password_confirmation = newpass
      user.listener = true
      user.about = "This \'ere user ain\'t filled out their profile yet"
      if user.save
        flash[:notice] = "Signed in successfully."
        UserSession.create(user, true)
        initialize_chatroom
        
        redirect_back_or_default listener_path
      else        
        Rails.logger.info user.errors.to_json
        session[:omniauth] = omniauth.except('extra')
        redirect_back_or_default('/')
      end
    end
  end

  def destroy
  end
    
  def passthru
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/public/404.html", :status => :not_found, :layout => false }
    end
  end

end
