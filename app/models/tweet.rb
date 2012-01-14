class Tweet < ActiveRecord::Base

  belongs_to :user
  has_many :feed_items
  
  validates_presence_of :tid, :user_id, :body

end
