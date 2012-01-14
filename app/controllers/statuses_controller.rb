class StatusesController < ApplicationController
  
  def index
  end

  def show
  end

  def new
  end
  
  def create
    @status = Status.new
    @status.user = current_user
    @status.body = params[:status_update]
    if current_user.staff
      if params[:announcement].to_i == 1
        @status.announcement = true
      end
    end
    if @status.save
      respond_to do |format|
        format.js { render :partial => "saved.js"}
      end
    else
      respond_to do |format|
        format.js { render :partial => "error.js"}
      end
    end
  end

  def edit
  end

  def destroy
    @status = Status.find(params[:id])
    if current_user.id == @status.user_id
      if @status.destroy
        respond_to do |format|
          format.js { render :partial => "deleted.js" }
        end
      end
    elsif current_user.staff
      if @status.destroy
        respond_to do |format|
          format.js { render :partial => "deleted.js" }
        end
      end
    end
  end

end
