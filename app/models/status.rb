class Status < ActiveRecord::Base
  belongs_to :user
  has_many :feed_items
  validates_presence_of :body, :user_id
end
