class Role < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :abilities
  validates_uniqueness_of :title
end
