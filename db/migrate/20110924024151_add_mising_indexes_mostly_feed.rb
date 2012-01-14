class AddMisingIndexesMostlyFeed < ActiveRecord::Migration
  def self.up
    
    # These indexes were found by searching for AR::Base finds on your application
    # It is strongly recommanded that you will consult a professional DBA about your infrastucture and implemntation before
    # changing your database in that matter.
    # There is a possibility that some of the indexes offered below is not required and can be removed and not added, if you require
    # further assistance with your rails application, database infrastructure or any other problem, visit:
    #
    # http://www.railsmentors.org
    # http://www.railstutor.org
    # http://guides.rubyonrails.org

    
    add_index :feed_items, :program_id
    add_index :feed_items, :status_id
    add_index :feed_items, :post_id
    add_index :feed_items, :comment_id
    add_index :feed_items, :playlist_id
    add_index :feed_items, :tweet_id
    add_index :feed_items, :feed_id
    add_index :feed_items, :strike_id
    add_index :feed_items, :event_id
    add_index :feed_items, :review_id
    add_index :feeds, :user_id
    add_index :messages, :user_id
    add_index :messages, :chatroom_id
    add_index :chatrooms, :user_id
    add_index :comments, :profile_id
    add_index :comments, :recipient_id
    add_index :comments, :volunteer_hour_id
    add_index :downloads, :program_id
    add_index :downloads, :user_id
    add_index :downloads, :playlist_id
    add_index :tweets, :user_id
    add_index :assets, :post_id
    add_index :assets, :user_id
    add_index :photos, :program_id
    add_index :photos, :user_id
    add_index :unique_objs, [:objectifiable_id, :objectifiable_type]
    add_index :statuses, :user_id
    add_index :events, :program_id
    add_index :featured_artists, :artist_id
    add_index :strikes, :issued_by
    add_index :strikes, :user_id
    add_index :views, [:viewable_id, :viewable_type]
    add_index :authentications, :user_id
    add_index :reviews, :album_id
    add_index :reviews, :artist_id
    add_index :reviews, :label_id
    add_index :reviews, :genre_id
    add_index :abilities_roles, [:role_id, :ability_id]
    add_index :abilities_roles, [:ability_id, :role_id]
    add_index :volunteer_hours, :user_id
    add_index :roles, :user_id
    add_index :users, :email
    add_index :users, :perishable_token
    add_index :contents, :title
    add_index :labels, :name
    add_index :authentications, [:provider, :uid]
    add_index :authentications, [:uid, :provider]
    add_index :sections, :title
    add_index :user_groups, :name
    add_index :artists, :name
    add_index :content_types, :name
  end
  
  def self.down
    remove_index :feed_items, :program_id
    remove_index :feed_items, :status_id
    remove_index :feed_items, :post_id
    remove_index :feed_items, :comment_id
    remove_index :feed_items, :playlist_id
    remove_index :feed_items, :tweet_id
    remove_index :feed_items, :feed_id
    remove_index :feed_items, :strike_id
    remove_index :feed_items, :event_id
    remove_index :feed_items, :review_id
    remove_index :feeds, :user_id
    remove_index :messages, :sender_id
    remove_index :messages, :user_id
    remove_index :messages, :chatroom_id
    remove_index :messages, :recipient_id
    remove_index :chatrooms, :user_id
    remove_index :comments, :column => [:reply_id, :reply_type]
    remove_index :comments, :profile_id
    remove_index :comments, :recipient_id
    remove_index :comments, :volunteer_hour_id
    remove_index :downloads, :program_id
    remove_index :downloads, :user_id
    remove_index :downloads, :playlist_id
    remove_index :tweets, :user_id
    remove_index :assets, :post_id
    remove_index :assets, :user_id
    remove_index :assets, :reviews_id
    remove_index :assets, :playlist_id
    remove_index :photos, :program_id
    remove_index :photos, :user_id
    remove_index :photos, :playlist_id
    remove_index :photos, :review_id
    remove_index :unique_objs, :program_id
    remove_index :unique_objs, :column => [:objectifiable_id, :objectifiable_type]
    remove_index :unique_objs, :user_id
    remove_index :statuses, :user_id
    remove_index :events, :program_id
    remove_index :events, :user_id
    remove_index :featured_artists, :artist_id
    remove_index :strikes, :issued_by
    remove_index :strikes, :user_id
    remove_index :views, :program_id
    remove_index :views, :column => [:viewable_id, :viewable_type]
    remove_index :views, :user_id
    remove_index :views, :playlist_id
    remove_index :authentications, :user_id
    remove_index :reviews, :album_id
    remove_index :reviews, :artist_id
    remove_index :reviews, :label_id
    remove_index :reviews, :genre_id
    remove_index :abilities_roles, :column => [:role_id, :ability_id]
    remove_index :abilities_roles, :column => [:ability_id, :role_id]
    remove_index :volunteer_hours, :user_id
    remove_index :roles, :user_id
  end
end
