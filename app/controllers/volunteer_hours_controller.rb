class VolunteerHoursController < ApplicationController
  layout 'auxiliary'
  
  before_filter :require_user, :only => ['edit', 'update', 'create', 'respond']
  before_filter :no_listener
  before_filter :is_staff, :only => ['index', 'approve', 'deny']

  def index
    @vh = VolunteerHour.where(:approved => nil)
    respond_to do |format|
      format.js { render :partial => "index" }
    end
  end

  def edit
    
  end

  def new
    
  end
  
  def approve
    @vh = VolunteerHour.find(params[:id])
    @vh.approved = true
    if @vh.save
      respond_to do |format|
        format.js { render :partial => "approved.js" }
      end
    else
      respond_to do |format|
        format.js { render :partial => "layouts/problem.js" }
      end
    end
  end
  def respond
    @vh = VolunteerHour.find(params[:id])
    @vh.approved = nil
    @vhc = Comment.find(params[:vhcid])
    @comment = Comment.new(:user => current_user, :volunteer_hour_id => @vh.id, :body => params[:body], :recipient => @vhc.user)
    if @vh.save && @comment.save
      respond_to do |format|
        format.js { render :partial => "respond.js" }
      end
    else
      respond_to do |format|
        format.js { render :partial => "layouts/problem.js" }
      end
    end
  end
  
  def deny
    @vh = VolunteerHour.find(params[:id])
    @vh.approved = false
    @comment = Comment.new(:user => current_user, :volunteer_hour_id => @vh.id, :body => params[:body], :recipient => @vh.user)
    if @vh.save && @comment.save
      respond_to do |format|
        format.js { render :partial => "approved.js" }
      end
    else
      respond_to do |format|
        format.js { render :partial => "layouts/problem.js" }
      end
    end
  end

end
