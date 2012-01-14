require 'amazon/aws'
require 'amazon/aws/search'
include Amazon::AWS
include Amazon::AWS::Search
class Review < ActiveRecord::Base
  
  belongs_to :user
  has_many :photos
  has_many :comments
  has_many :assets
  has_many :feed_items
  belongs_to :artist
  belongs_to :genre
  belongs_to :album
  belongs_to :label
  belongs_to :genre

  acts_as_taggable
  acts_as_taggable_on :tags
  
  validates_presence_of :title, :body, :artist
  
  def album_cover_fetch
    artist, album = [self.artist.name, self.album.name]
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
  
end
