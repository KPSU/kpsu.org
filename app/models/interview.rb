class Interview < ActiveRecord::Base
  belongs_to :user
  has_one :genre
  has_many :comments
end
