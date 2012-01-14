class View < ActiveRecord::Base
  
  belongs_to :viewable, :polymorphic => true
  belongs_to :user
  belongs_to :program
  belongs_to :playlist
  belongs_to :artist
  
  
end
