class PasswordResetsController < ApplicationController
  before_filter :load_user_using_perishable_token, :only => [:edit, :update]
  layout 'alternative'
  def new
    render
  end

  def create
    @user = User.find_by_email(params[:reset][:email])
    if @user
      PasswordReset.password_reset_instructions(@user).deliver
      flash[:notice] = "Instructions to reset your password" +
        "have been emailed to you.\n" +
        "Please check your email."
      redirect_to (login_path)
    else
      flash[:notice] = "No user was found with that email address"
      render :action => :new
    end
  end

  def edit
    
  end

  def update
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.save
      flash[:notice] = "Password successfully updated"
      redirect_to dashboard_path
    else
      render :action => :edit
    end
  end

  private

  def load_user_using_perishable_token
    @user = User.find_by_perishable_token(params[:id])
    unless @user
      flash[:notice] = "Sorry, but we could not locate your account. " +
        "If you are having issues try copying and pasting the URL " +
        "from your email into your browser or restarting the " +
        "reset password process."
      redirect_to login_path
    end
  end
end