class SiteController < ApplicationController
  layout 'player'
  
  def featured_artist
    @featured_artists = FeaturedArtist.order("created_at DESC").limit(4)
    respond_to do |format|
      format.js {render :partial => "featured_artist" }
    end
  end
  
  private
  
  def choose_layout
    if ['player'].include? action_name
      'player'
    else
      'auxiliary'
    end
  end
  
end
