class Message < ActiveRecord::Base

  belongs_to :chatroom
  belongs_to :user
  
  belongs_to :sender, :class_name => "User"
  belongs_to :recipient, :class_name => "User"
  
  validates_presence_of :message, :sender, :recipient
end
