class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :pageviews
  has_many :photos
  has_many :assets
  has_many :feed_items
  belongs_to :content_type
  has_many :views, :as => :viewable
  
  acts_as_taggable
  acts_as_taggable_on :tags
  
  validates_presence_of :content_type, :title, :body, :user_id
  
  def images
    @images = []
    @images_array = self.assets.each do |i|
      if ['image/jpeg', 'image/pjpeg', 'image/gif', 'image/png', 'image/x-png', 'image/jpg'].include?(i.item.content_type)
        @images << i
      end
    end
    if @images.size > 0 && @images.size != nil
      return @images
    else
      return false
    end
  end
  
  def audio_files
    @audio_files = []
    @audio_array = self.assets.each do |i|
      if ['application/mp3', 'application/x-mp3', 'audio/mpeg', 'audio/mp3'].include?(i.item.content_type)
        @audio_files << i
      end
    end
    if @audio_files.size > 0 && @images.size != nil
      return @audio_files
    else
      return false
    end
  end
  
  
end
