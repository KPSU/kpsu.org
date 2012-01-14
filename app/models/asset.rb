class Asset < ActiveRecord::Base
  
  PHOTO_TINY_W = 55
  PHOTO_TINY_H = 55
  PHOTO_THUMB_W = 100
  PHOTO_THUMB_H = 100
  PHOTO_BIG_THUMB_W = 150
  PHOTO_BIG_THUMB_H = 150
  PHOTO_HUGE_THUMB_W = 200
  PHOTO_HUGE_THUMB_H = 200
  belongs_to :user
  belongs_to :post
  belongs_to :playlist
  belongs_to :reviews
  has_attached_file :item,
                    :styles => lambda { |a|
                                if a.instance.thumbnailable?
                                  logger.info a
                                  
                                  {:tiny => "#{PHOTO_TINY_W}x#{PHOTO_TINY_H}>",
                                   :thumb => "#{PHOTO_THUMB_W}x#{PHOTO_THUMB_H}>",
                                   :big_thumb => "#{PHOTO_BIG_THUMB_W}x#{PHOTO_BIG_THUMB_H}>",
                                   :huge_thumb => "#{PHOTO_HUGE_THUMB_W}x#{PHOTO_HUGE_THUMB_H}>"}
                                elsif a.instance.playable?
                                  {:audio => {}}
                                end
                                },
                    :url => "/system/files/:style/:id/:basename.:extension",
                    :path => ":rails_root/public/system/files/:style/:id/:basename.:extension",
                    :processors => lambda {|a|
                                if a.thumbnailable?
                                  [:thumbnail]
                                elsif a.playable?
                                end
                      }
                      
  validates_attachment_presence :item
  validates_presence_of :user, :title
  validates_attachment_size :item, :less_than => 100.megabytes,
                                    :message => 'File must be less than 100 Megabytes, please email: admin@kpsu.org for support with larger files'
                                 
  validates_attachment_content_type :item, :content_type => [ 'application/mp3', 'application/x-mp3', 'audio/mpeg', 'audio/mp3','image/jpeg', 'image/pjpeg', 'image/gif', 'image/png', 'image/x-png', 'image/jpg' ],
                  :message => 'file must be of filetype .mp3, .jpg, .gif, or .png, please email: admin@kpsu.org to have additional filetypes supported'
  def playable?
    return false unless item.content_type
    ['application/mp3', 'application/x-mp3', 'audio/mpeg', 'audio/mp3'].join('').include?(item.content_type)
  end
                    
  def thumbnailable?
    return false unless item.content_type
    ['image/jpeg', 'image/pjpeg', 'image/gif', 'image/png', 'image/x-png', 'image/jpg'].join('').include?(item.content_type)
  end
  
  def full_url(size, hostname)
    hostname.to_s+self.item.url(size).to_s
  end
  
end
