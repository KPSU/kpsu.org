class FeedItem < ActiveRecord::Base
  
  belongs_to :feed
  belongs_to :comment
  belongs_to :status
  belongs_to :program
  belongs_to :post
  belongs_to :review
  belongs_to :playlist
  belongs_to :event
  belongs_to :tweet
  belongs_to :strike
  
end
