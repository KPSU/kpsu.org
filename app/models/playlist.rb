class Playlist < ActiveRecord::Base

  acts_as_taggable
  acts_as_taggable_on :tags

  belongs_to :program
  belongs_to :user
  has_one :genre
  has_many :playlist_items
  has_many :tracks, :through => :playlist_items
  has_many :comments
  has_many :feed_items
  has_many :artist_playlists
  has_many :artists, :through => :artist_playlists
  has_many :views, :as => :viewable
  
  validates_presence_of :user, :program, :title
  
  default_value_for :description, "No description this week!" 
  default_value_for :title, "#{Time.zone.now.strftime("%A %B\%e %Y")}"
  
  def to_param
    title.gsub(/[\.]|[\/]/, "_").gsub(/[\s]/, "-").downcase
  end

    def self.find(*args)
    
    unless args[0].to_i > 0
      @title = args[0].gsub(/[\-]/, " ").downcase
      find(:first, :conditions => ['title LIKE ?', @title])
    else
      super
    end
  end

  def ptracks
    if self.playlist_items != nil
      @u = self.playlist_items
      @u = @u.sort! { |a,b| a.position <=> b.position }
      @tracks = []
      @u.each do |t|
        @tracks << t.track
      end
      return @tracks
    end
  end
  
end
