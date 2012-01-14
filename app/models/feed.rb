class Feed < ActiveRecord::Base

  belongs_to :user
  has_many :feed_items
  has_many :comments, :through => 'comment_id'
  
  def self.get_items
    
    item_list = []
    items = find(:all, :order => "created_at DESC", :limit => 30)
    items.each do |i|
      item_list << i.item_type.constantize.find(i.item_id)
    end
    item_list
    
  end

end
