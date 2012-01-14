class Strike < ActiveRecord::Base

  belongs_to :user
  belongs_to :issued_by, :class_name => "User", :foreign_key => "issued_by"
  has_many :feed_items

end
