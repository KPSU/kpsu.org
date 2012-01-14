class VolunteerHour < ActiveRecord::Base

  belongs_to :user
  has_many :comments
  validates_presence_of :user_id, :description, :v_date, :hours
  
end
