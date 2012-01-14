class HappeningsController < ApplicationController

  def index
    @happenings = Happening.where("starts_at > ?", Time.now - 1.hour)
    respond_to do |format|
      format.js {render :partial => "index"}
    end
  end
  
  def new
  end
  
  def find
    @happenings = Happening.title_like(params[:find_title])
    if @happenings
      respond_to do |format|
        format.js {render :partial => "results.js.erb"}
      end
    else
      respond_to do |format|
        format.js {render :partial => "error.js.erb" }
      end
    end
  end
  
  def create
    @happening = Happening.new
    @starts_at = "#{params[:starts_at][:month]}/" + "#{params[:starts_at][:day]}/" + "#{params[:starts_at][:year]}" + " #{params[:starts_at][:hour]}\:" + "#{params[:starts_at][:minute]}"
    @ends_at = "#{params[:ends_at][:month]}/" + "#{params[:ends_at][:day]}/" + "#{params[:ends_at][:year]}" + " #{params[:ends_at][:hour]}\:" + "#{params[:ends_at][:minute]}"
    @happening.title = params[:title]
    @happening.description = params[:description]
    @happening.url = params[:url]
    @happening.contact_email = params[:contact_email]
    @happening.starts_at = @starts_at
    @happening.ends_at = @ends_at
    if @happening.save
      respond_to do |format|
        format.js { render :partial => "saved.js.erb" }
      end
    else
      respond_to do |format|
        format.js { render :partial => "error.js.erb" }
      end
    end
  end
  
  def update
    @happening = Happening.new
    @starts_at = "#{params[:edit_starts_at][:month]}/" + "#{params[:edit_starts_at][:day]}/" + "#{params[:edit_starts_at][:year]}" + " #{params[:edit_starts_at][:hour]}\:" + "#{params[:edit_starts_at][:minute]}"
    @ends_at = "#{params[:edit_ends_at][:month]}/" + "#{params[:edit_ends_at][:day]}/" + "#{params[:edit_ends_at][:year]}" + " #{params[:edit_ends_at][:hour]}\:" + "#{params[:edit_ends_at][:minute]}"
    @happening.title = params[:edit_title]
    @happening.description = params[:edit_description]
    @happening.url = params[:edit_url]
    @happening.contact_email = params[:edit_contact_email]
    @happening.starts_at = @starts_at
    @happening.ends_at = @ends_at
    if @happening.save
      respond_to do |format|
        format.js { render :partial => "saved.js.erb" }
      end
    else
      respond_to do |format|
        format.js { render :partial => "error.js.erb" }
      end
    end
  end
  
  def destroy
    @happening = Happening.find(params[:id])
    if @happening
      respond_to do |format|
        format.js {render :text => "Success! The event has been removed"}
      end
    else
      respond_to do |format|
        format.js {render :text => "Aww shucks! The fail train is here, and we couldn't remove that event."}
      end
    end
  end

end
