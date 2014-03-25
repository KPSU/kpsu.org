#class StaticController < ApplicationController
  
  #def index
  #  @month = (params[:month] || Time.zone.now.month).to_i
  #  @year = (params[:year] || Time.zone.now.year).to_i

  #  @shown_month = Date.civil(@year, @month)

  #  @event_strips = Event.event_strips_for_month(@shown_month)
  #end

  #The above was an old implementation that was sitting there.  Below is my attempt at creating a semi-static page from here:
  #http://stackoverflow.com/questions/5911794/adding-a-new-page-in-ruby-on-rails

class StaticController < ApplicationController
  layout 'alternative'
  def show
    if params[:page] == "calendar"
      render params[:page]
    else
      raise ActionController::RoutingError.new('Not Found') 
    end
  end

  def kruise
    redirect_to "http://www.portlandspirit.com"
  end

  def pledge
    redirect_to "https://www.foundation.pdx.edu/publicgift/kpsu.jsp"
  end

end