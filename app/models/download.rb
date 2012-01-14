class Download < ActiveRecord::Base
  belongs_to :user
  belongs_to :program
  belongs_to :playlist
  
  validates_uniqueness_of :title
  validates_presence_of :title
end
