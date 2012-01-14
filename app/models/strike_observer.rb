class StrikeObserver < ActiveRecord::Observer
  
  def after_create(record)
    @user = User.find(record.user_id)
    f = Feed.find_or_create_by_user_id(@user.id)
    @fi = FeedItem.new(:feed_id => f.id, :strike_id => record.id)
    @fi.save
  end
  
  def before_destroy(record)
      @fi = FeedItem.where(:strike_id => record.id)
      @fi.each do |f|
        FeedItem.delete(f)
      end
  end
  
end
