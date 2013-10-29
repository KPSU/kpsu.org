require 'open-uri'
class User < ActiveRecord::Base

  PHOTO_TINY_W = 55
  PHOTO_TINY_H = 55
  PHOTO_THUMB_W = 100
  PHOTO_THUMB_H = 100
  PHOTO_BIG_THUMB_W = 150
  PHOTO_BIG_THUMB_H = 150
  
  acts_as_authentic
  acts_as_network :messages, :through => :mails
  attr_accessor :image_url

  has_many :posts
  has_many :comments
  has_many :interviews
  has_many :photos
  has_many :programs
  has_many :playlists
  has_many :reviews
  has_many :downloads
  has_many :tweets
  
  has_and_belongs_to_many :user_groups, :join_table => :user_groups_users
  
  has_many :roles
  has_many :authentications
  has_many :profile_comments, :class_name => "Comment", :foreign_key => 'profile_id'
  has_many :comments_recived, :class_name => "Comment", :foreign_key => "recipient_id"
  has_one  :feed
  has_many :volunteer_hours
  has_many :statuses
  has_many :strikes
  has_many :views, :as => :viewable
  has_many :unique_objs, :as => :objectifiable
  
  if ::Rails.env == "development"
    @url = "/system/files/avatars/:id/:style/:basename.:extension"
  else
    @url = "/system/files/avatars/:id/:style/:basename.:extension"
  end

  has_attached_file :avatar,
                    :url => @url,
                    :path => ":rails_root/public/system/files/avatars/:id/:style/:basename.:extension",
                    :default_url => "/images/default-avatar.png",
                    :styles =>  { :tiny => "#{PHOTO_TINY_W}x#{PHOTO_TINY_H}>",
                                  :thumb => "#{PHOTO_THUMB_W}x#{PHOTO_THUMB_H}>",
                                  :big_thumb => "#{PHOTO_BIG_THUMB_W}x#{PHOTO_BIG_THUMB_H}>",
                                  :square_thumb_tiny => "#{PHOTO_TINY_W}x#{PHOTO_TINY_H}#",
                                  :square_thumb_big => "#{PHOTO_BIG_THUMB_W}x#{PHOTO_BIG_THUMB_H}#" }
                                  
  before_validation :download_remote_image, :if => :image_url_provided?  
  validates_presence_of :image_remote_url, :if => :image_url_provided?, :message => 'is invalid or inaccessible'
  
  validates_presence_of :dj_name, allow_blank: false, format: {
    message: 'Please enter a DJ name, it can be the same as your full name if you don\'t have one' 
  }
  validates_presence_of :f_name, allow_blank: false, format: {
    message: 'Please enter a first name' 
  }
  validates_presence_of :l_name, allow_blank: false, format: {
    message: 'Please enter a last name' 
  }
  
  default_value_for :age, "0"
  default_value_for :about, "This DJ hasn\'t filled out any information yet, hastle \'em about it!" 
     

  def to_param
    dj_name.gsub(/[\.]|[\/]/, "_").gsub(/[\s]/, "_").gsub("-","_").downcase
  end

  def self.find(*args)   
    unless (args[0].class == Symbol) || (args[0].to_i > 0)
      find_by_dj_name(args[0].gsub("_", " "))
    else
      super
    end
  end
  
  def deliver_password_reset_instructions!
    reset_perishable_token!
    Notifier.deliver_password_reset_instructions(self)
  end
  
  def blogs
    @ct = ContentType.find_by_name("blog")
    @blogs = self.posts.find(:all, :conditions => ['content_type_id = ?', @ct.id], :order => 'created_at DESC')
    return @blogs
  end
  
  def staff
    @g = UserGroup.find_by_name("staff")
    if self.user_groups.include?(@g)
      return true
    else
      return false
    end
  end
  
  def admin
    @g = UserGroup.find_by_name("Administrators")
    if self.user_groups.include?(@g)
      return true
    else
      return false
    end
  end
  
  def is_able_to(ability)
    self.roles.each do |r| 
      unless r.abilites.empty? 
        r.abilities.each do |a| 
        if a.title == ability 
          @poo = true 
        else 
          @poo = false 
        end
      end
      end
    end
  end
  
  def recent_blogs
    @ct = ContentType.find_by_name("blog")
    @blogs = self.posts.find(:all, :conditions => ['content_type_id = ?', @ct.id], :order => 'created_at DESC', :limit => 4)
    return @blogs
  end
  
  def apply_omniauth(omniauth)
    authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
    if omniauth['provider'] == "facebook"
      self.f_name = omniauth['user_info']['first_name']
      self.l_name = omniauth['user_info']['last_name']
    elsif omniauth['provider'] == "twitter"
      self.f_name = omniauth['user_info']['name']
      self.l_name = ""
    end
  end
  
  def monthly_hours(month, days)
    @end_month = Time.parse("#{month}/#{days}/#{Time.zone.now.year}")
    @beg_month = Time.parse("#{month}/1/#{Time.zone.now.year}")
    @v = VolunteerHour.where(:user_id => self.id, :v_date => (@beg_month..@end_month), :approved => true)
    @hours = 0
    @v.each do |v|
      @hours += v.hours
    end
    return @hours
  end
  
  def pending_hours(month, days)
    @end_month = Time.parse("#{month}/#{days}/#{Time.zone.now.year}")
    @beg_month = Time.parse("#{month}/1/#{Time.zone.now.year}")
    @v = VolunteerHour.where(:user_id => self.id, :v_date => (@beg_month..@end_month), :approved => false)
    @hours = 0
    @v.each do |v|
      @hours += v.hours
    end
    return @hours
  end
  
  def total_hours
    @vh = self.volunteer_hours.all
    @hours = 0
    @vh.each do |vh|
      @hours += vh.hours
    end
    return @hours || 0
  end
  
  def profile_views
    return self.views.size
  end
  
  def profile_views_within(time)
    @v = self.views.where("created_at >= ?", time)
    return @v.size
  end
  
  def program_views
    @pros = self.programs
    @i = 0
    @pros.each do |pro|
      @i = pro.views.size + @i
    end
    return @i
  end
  
  def program_views_within(time)
    @total = 0
    @pros = self.programs
    @pros.each do |program|
      @views = program.views.where("created_at >= ?", time)
      @total += @views.size
    end
    return @total
  end
  
  def playlist_views
    @pros = self.playlists
    @i = 0
    @pros.each do |pro|
      @i = pro.views.size + @i
    end
    return @i
  end
  
  def playlist_views_within(time)
    @total = 0
    @plays = self.playlists
    @plays.each do |playlist|
      @views = playlist.views.where("created_at >= ?", time)
      @total = @total + @views.count
    end
    return @total
  end
  
  def total_downloads
    @total = 0
    @d = self.downloads
    @d.each do |download|
      @total = @total + download.count
    end
    return @total
  end
  
  def total_downloads_within(time)
    @total = 0
    @d = self.downloads.where("created_at >= ?", time)
    @d.each do |download|
      if(download.count != nil) 
        @total = @total + download.count
      end
    end
    return @total
  end
  
  def post_views_within(time)
    @total = 0
    @p = self.posts
    @p.each do |post|
      @_post = post.views.where("created_at >= ?", time)
      @total = @total + @_post.count
    end
    return @total
  end
  
  def total_posts
    @total = 0
    @p = self.posts
    @p.each do |post|
      @total = @total + post.count
    end
  end
  
  def dj_score
    @four_weeks = Date.today-4.weeks
    @eight_weeks = Date.today-8.weeks
    @six_weeks = Date.today-6.weeks
    
    @dl_total = self.total_downloads_within(@four_weeks)
    @pr_total = self.program_views_within(@four_weeks)
    @pl_total = self.playlist_views_within(@six_weeks)
    @po_total = self.post_views_within(@eight_weeks)
    
    @u_total  = self.profile_views_within(@four_weeks).size
    @u_comments = self.comments.where("created_at > ?", @eight_weeks).size
    
    @score = ((@dl_total*2)+(@pr_total)+(@po_total*5)+(@pl_total*3)+(@u_total)+(@u_comments*20))
    
    return @score
  end

  # Popularity does not take an argument because
  # the metric itself is about how popular a dj is
  # currently. 

  def popularity_score
    @one_week = Date.today-1.week
    
    @profile_views = self.profile_views_within(@one_week)
    @playlist_views = self.playlist_views_within(@one_week)
    @prog_views = self.program_views_within(@one_week)

    @score = (@prog_views + @profile_views + @playlist_views)
    return @score
  end
  
  def url_slug
      return self.gsub(/[\.]|[\/]/, "_").gsub(/[\s]/, "_").gsub("-","_").downcase
  end

  private



  def image_url_provided?
    !self.image_url.blank?
  end
  
  def download_remote_image
    self.avatar = do_download_remote_image
    self.image_remote_url = image_url
  end
  
  def do_download_remote_image
    io = open(URI.parse(image_url))
    def io.original_filename; base_uri.path.split('/').last; end
    io.original_filename.blank? ? nil : io
  rescue # catch url errors with validations instead of exceptions (Errno::ENOENT, OpenURI::HTTPError, etc...)
  end

  
end
