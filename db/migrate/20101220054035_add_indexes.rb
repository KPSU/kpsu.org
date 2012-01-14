class AddIndexes < ActiveRecord::Migration
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


      add_index :playlists, :program_id
      add_index :playlists, :user_id
      add_index :albums, :label_id
      add_index :albums, :artist_id
      add_index :programs, :genre_id
      add_index :programs, :user_id
      add_index :reviews, :user_id
      add_index :contents, :section_id
      add_index :posts, :content_type_id
      add_index :posts, :user_id
      add_index :tracks, :artist_id
      add_index :tracks, :album_id
      add_index :interviews, :user_id
      add_index :user_groups_users, [:user_group_id, :user_id]
      add_index :user_groups_users, [:user_id, :user_group_id]
    end

    def self.down

      remove_index :playlists, :program_id
      remove_index :playlists, :user_id
      remove_index :albums, :label_id
      remove_index :albums, :artist_id
      remove_index :programs, :genre_id
      remove_index :programs, :user_id
      remove_index :reviews, :user_id
      remove_index :contents, :section_id
      remove_index :posts, :content_type_id
      remove_index :posts, :user_id
      remove_index :tracks, :artist_id
      remove_index :tracks, :album_id
      remove_index :interviews, :user_id
      remove_index :user_groups_users, :column => [:user_group_id, :user_id]
      remove_index :user_groups_users, :column => [:user_id, :user_group_id]
    end
end
