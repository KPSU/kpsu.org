class PostObserver < ActiveRecord::Observer

  def after_create(record)
    @users = User.where(:listener => false)
    @users.each do |u|
      f = Feed.find_or_create_by_user_id(u.id)
      @fi = FeedItem.new(:feed_id => f.id, :post_id => record.id)
      @fi.save
    end
  end
  
  def before_destroy(record)
      @fi = FeedItem.where(:post_id => record.id)
      @fi.each do |f|
        FeedItem.delete(f)
      end
  end

end
