class Event < ActiveRecord::Base
  belongs_to :user
  belongs_to :program
  has_many :feed_items  
  acts_as_taggable
  acts_as_taggable_on :tags
  
  validates_presence_of :day_i
  validates_uniqueness_of :name
  validates_uniqueness_of :starts_at, :scope => :day_i, :message => "There is already a show starting at this time, please choose another day or time."
  validates_uniqueness_of :ends_at, :scope => :day_i, :message => "There is already a show ending at this time, please choose another day or time."
  
  def duration
    @duration = (self.ends_at - self.starts_at)/60/60
    return @duration
  end
  
  
  
end
