class CommentObserver < ActiveRecord::Observer
  observe :comment
  
  def after_create(record)
    
    if record.recipient
      u = record.recipient
    elsif record.reply_id
      u = record.reply_id
    elsif record.post_id
      u = record.post.user
    elsif record.playlist_id
      u = record.playlist.user
    elsif record.review_id
      u = record.review.user
    elsif record.program_id
      u = record.program.user
    end 
      
    f = Feed.find_or_create_by_user_id(u.id)
    @fi = FeedItem.new(:feed_id => f.id, :comment_id => record.id)
    @fi.save
    UserMailer.new_comment(u, record).deliver
  end
  
end