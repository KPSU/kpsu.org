class Photo < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :interview
  belongs_to :playlist
  belongs_to :program
  belongs_to :review
  has_many :comments
  
  has_attached_file :photo, :styles => {
      :thumb_tiny => "50x50>",
      :thumb => "100x00>",
      :small => "200x00>",
      :medium => "300x300>",
      :large => "500x500>"
  }
  
  acts_as_taggable
  acts_as_taggable_on :tags
  
  
  
end
