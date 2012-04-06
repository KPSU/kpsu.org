class UserSessionsController < ApplicationController
  
  layout 'alternative'

  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    @user_session.save do |result|
      if result
        
        flash[:notice] = "Login successful!"
        redirect_back_or_default dashboard_path
      else
        render :action => :new
      end
    end
  end

  def destroy
    current_user_session.destroy
    #reset_lockdown_session
    flash[:notice] = "Logout successful!"
    redirect_to("/")
  end

  private

  def set_lockdown_values
    if user = @user_session.user
      add_lockdown_session_values(user)
    end
  end
end