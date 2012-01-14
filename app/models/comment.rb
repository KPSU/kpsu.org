class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :interview
  belongs_to :photo
  belongs_to :playlist
  belongs_to :post
  belongs_to :program
  belongs_to :review
  has_many :feed_items
  belongs_to :reply, :polymorphic => true
  belongs_to :profile_comments, :class_name => "User", :foreign_key => "profile_id"
  belongs_to :recipient, :class_name => "User", :foreign_key => "recipient_id"
  belongs_to :volunteer_hour
  has_many :comments, :as => :reply
  
  def rendered_title    
    if self.volunteer_hour_id?
      @vh = VolunteerHour.find(self.volunteer_hour_id)
      Rails.logger.info { "#{self.volunteer_hour_id}" }
      
      if @vh.approved == false
        @approved = "denied."
      elsif @vh.approved == true
        @approved = "approved."
      end
      @title = "Volunteer hours for #{self.volunteer_hour.v_date.to_s(:simple)} have been #{@approved}"
      return @title
    elsif self.post_id?
      @p = Post.find(self.post_id)
      @title = "RE: #{@p.title}"
      return @title
    elsif self.profile_id?
      @title = "Profile Comment"
      return @title
    else
      @title = "Something"      
    end
    
    
  end
  
end
