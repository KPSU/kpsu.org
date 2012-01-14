class StrikesController < ApplicationController

  def index
    @strikes = Strike.order("created_at DESC").limit(5)
    respond_to do |format|
      format.js {render :partial => "index" }
    end
  end
  
  def user_search
    @results = User.f_name_like(params[:user_search]).where(:listener => false)
    respond_to do |format|
      format.js { render :partial => "user_search.js.erb"}
    end
  end
  
  def user_lookup
    @results = User.f_name_like(params[:user_lookup]).where(:listener => false)
    respond_to do |format|
      format.js { render :partial => "user_lookup.js.erb"}
    end    
  end
  
  def create
    @user = User.find(params[:issue_to])
    @strike = Strike.new(:description => params[:description], :user => @user, :issued_by => current_user)
    if @strike.save
      respond_to do |format|
        format.js { render :partial => "saved.js.erb" }
      end
    else
    end
  end
  
  
end
