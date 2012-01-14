class TopDj < ActiveRecord::Base

	has_one :unique_obj, :as => :objectifiable, :dependent => :destroy
	belongs_to :user
	belongs_to :program
	
	accepts_nested_attributes_for :unique_obj

end
