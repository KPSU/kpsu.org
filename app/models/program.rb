class Program < ActiveRecord::Base
  
  PHOTO_TINY_W = 55
  PHOTO_TINY_H = 55
  PHOTO_THUMB_W = 100
  PHOTO_THUMB_H = 100
  PHOTO_BIG_THUMB_W = 300
  PHOTO_BIG_THUMB_H = 300
  
  belongs_to :user
  has_many :photos
  has_many :comments
  belongs_to :genre
  has_many :playlists
  has_one :event
  has_many :downloads
  has_many :feed_items
  has_many :views, :as => :viewable
  
  validates_presence_of :title
  validates_uniqueness_of :title
  
  has_attached_file :thumb,
                    :url => "/system/files/programs/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/system/files/programs/:id/:style/:basename.:extension",
                    :default_url => "/images/default-avatar.png",
                    :styles =>  { :tiny => "#{PHOTO_TINY_W}x#{PHOTO_TINY_H}>",
                                  :thumb => "#{PHOTO_THUMB_W}x#{PHOTO_THUMB_H}>",
                                  :big_thumb => "#{PHOTO_BIG_THUMB_W}x#{PHOTO_BIG_THUMB_H}>",
                                  :square_thumb => "#{PHOTO_BIG_THUMB_W}x{PHOTO_BIG_THUMB_H}#" }
  
  acts_as_taggable
  acts_as_taggable_on :tags
  def to_param
    title.gsub(" ", "-").downcase
  end

  def self.find(*args)
    
    unless args[0].to_i > 0
      find_by_title(args[0].gsub("-", " "))
    else
      super
    end
  end
  
  def showtime
    @e = Event.find(:last, :conditions => ['program_id = ?', self.id])
    return @e
  end
  
end
