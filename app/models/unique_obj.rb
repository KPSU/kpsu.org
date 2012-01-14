class UniqueObj < ActiveRecord::Base
  
  belongs_to :objectifiable, :polymorphic => true
  
  belongs_to :user
  belongs_to :program
  
end
