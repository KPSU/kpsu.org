# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120111020903) do

  create_table "abilities", :force => true do |t|
    t.integer  "role_id"
    t.string   "title"
    t.text     "description"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "ajax"
  end

  create_table "abilities_roles", :id => false, :force => true do |t|
    t.integer  "role_id"
    t.integer  "ability_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "abilities_roles", ["ability_id", "role_id"], :name => "index_abilities_roles_on_ability_id_and_role_id"
  add_index "abilities_roles", ["role_id", "ability_id"], :name => "index_abilities_roles_on_role_id_and_ability_id"

  create_table "albums", :force => true do |t|
    t.string   "name"
    t.integer  "artist_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "year"
    t.integer  "label_id"
    t.boolean  "catalog"
  end

  add_index "albums", ["artist_id"], :name => "index_albums_on_artist_id"
  add_index "albums", ["id"], :name => "index_albums_on_id"
  add_index "albums", ["label_id"], :name => "index_albums_on_label_id"

  create_table "artist_playlists", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "playlist_id"
    t.integer  "artist_id"
  end

  create_table "artists", :force => true do |t|
    t.string   "name"
    t.string   "about"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "catalog"
    t.string   "brainz_id"
  end

  add_index "artists", ["name"], :name => "index_artists_on_name"

  create_table "assets", :force => true do |t|
    t.string   "item_file_name"
    t.string   "item_content_type"
    t.integer  "item_file_size"
    t.datetime "item_updated_at"
    t.string   "title"
    t.text     "description"
    t.integer  "user_id"
    t.integer  "post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "review_id"
  end

  add_index "assets", ["post_id"], :name => "index_assets_on_post_id"
  add_index "assets", ["user_id"], :name => "index_assets_on_user_id"

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "authentications", ["provider", "uid"], :name => "index_authentications_on_provider_and_uid"
  add_index "authentications", ["uid", "provider"], :name => "index_authentications_on_uid_and_provider"
  add_index "authentications", ["user_id"], :name => "index_authentications_on_user_id"

  create_table "catalogs", :force => true do |t|
    t.integer  "number"
    t.string   "artist"
    t.string   "album"
    t.string   "year"
    t.string   "label"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "nid"
  end

  add_index "catalogs", ["id"], :name => "index_catalogs_on_id"

  create_table "chatrooms", :force => true do |t|
    t.integer  "user_id"
    t.string   "tite"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "chatrooms", ["user_id"], :name => "index_chatrooms_on_user_id"

  create_table "comments", :force => true do |t|
    t.string   "title"
    t.string   "body"
    t.integer  "user_id"
    t.integer  "post_id"
    t.integer  "playlist_id"
    t.integer  "program_id"
    t.integer  "interview_id"
    t.integer  "review_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "photo_id"
    t.integer  "reply_id"
    t.integer  "profile_id"
    t.integer  "volunteer_hour_id"
    t.integer  "recipient_id"
  end

  add_index "comments", ["interview_id"], :name => "index_comments_on_interview_id"
  add_index "comments", ["photo_id"], :name => "index_comments_on_photo_id"
  add_index "comments", ["playlist_id"], :name => "index_comments_on_playlist_id"
  add_index "comments", ["post_id"], :name => "index_comments_on_post_id"
  add_index "comments", ["profile_id"], :name => "index_comments_on_profile_id"
  add_index "comments", ["program_id"], :name => "index_comments_on_program_id"
  add_index "comments", ["recipient_id"], :name => "index_comments_on_recipient_id"
  add_index "comments", ["review_id"], :name => "index_comments_on_review_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"
  add_index "comments", ["volunteer_hour_id"], :name => "index_comments_on_volunteer_hour_id"

  create_table "content_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "content_types", ["name"], :name => "index_content_types_on_name"

  create_table "contents", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "section_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contents", ["section_id"], :name => "index_contents_on_section_id"
  add_index "contents", ["title"], :name => "index_contents_on_title"

  create_table "docs", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "download_champs", :force => true do |t|
    t.integer  "user_id"
    t.integer  "program_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "downloads", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "count"
    t.integer  "program_id"
    t.integer  "playlist_id"
    t.integer  "user_id"
    t.string   "url"
    t.integer  "file_size"
  end

  add_index "downloads", ["id", "user_id", "program_id"], :name => "index_downloads_on_id_and_user_id_and_program_id"
  add_index "downloads", ["id"], :name => "index_downloads_on_id"
  add_index "downloads", ["playlist_id"], :name => "index_downloads_on_playlist_id"
  add_index "downloads", ["program_id"], :name => "index_downloads_on_program_id"
  add_index "downloads", ["user_id"], :name => "index_downloads_on_user_id"

  create_table "events", :force => true do |t|
    t.string   "name"
    t.time     "starts_at"
    t.time     "ends_at"
    t.boolean  "all_day",    :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "day_i"
    t.integer  "program_id"
  end

  add_index "events", ["id"], :name => "index_events_on_id"
  add_index "events", ["program_id"], :name => "index_events_on_program_id"

  create_table "featured_artists", :force => true do |t|
    t.integer  "artist_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "featured_artists", ["artist_id"], :name => "index_featured_artists_on_artist_id"

  create_table "feed_items", :force => true do |t|
    t.integer  "feed_id"
    t.integer  "comment_id"
    t.string   "content_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status_id"
    t.integer  "program_id"
    t.integer  "post_id"
    t.integer  "review_id"
    t.integer  "playlist_id"
    t.integer  "event_id"
    t.integer  "tweet_id"
    t.integer  "strike_id"
  end

  add_index "feed_items", ["comment_id"], :name => "index_feed_items_on_comment_id"
  add_index "feed_items", ["event_id"], :name => "index_feed_items_on_event_id"
  add_index "feed_items", ["feed_id"], :name => "index_feed_items_on_feed_id"
  add_index "feed_items", ["id"], :name => "index_feed_items_on_id"
  add_index "feed_items", ["playlist_id"], :name => "index_feed_items_on_playlist_id"
  add_index "feed_items", ["post_id"], :name => "index_feed_items_on_post_id"
  add_index "feed_items", ["program_id"], :name => "index_feed_items_on_program_id"
  add_index "feed_items", ["review_id"], :name => "index_feed_items_on_review_id"
  add_index "feed_items", ["status_id"], :name => "index_feed_items_on_status_id"
  add_index "feed_items", ["strike_id"], :name => "index_feed_items_on_strike_id"
  add_index "feed_items", ["tweet_id"], :name => "index_feed_items_on_tweet_id"

  create_table "feeds", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "feeds", ["id"], :name => "index_feeds_on_id"
  add_index "feeds", ["user_id"], :name => "index_feeds_on_user_id"

  create_table "genres", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "handbook_pages", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "handbooks", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "happenings", :force => true do |t|
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.string   "title"
    t.text     "description"
    t.string   "url"
    t.string   "contact_email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "interviews", :force => true do |t|
    t.string   "title"
    t.text     "preface"
    t.text     "body"
    t.string   "interviewee"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "interviews", ["user_id"], :name => "index_interviews_on_user_id"

  create_table "labels", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "labels", ["name"], :name => "index_labels_on_name"

  create_table "mails", :force => true do |t|
    t.integer  "user_id"
    t.integer  "user_id_target"
    t.string   "subject"
    t.text     "body"
    t.boolean  "recipient_deleted"
    t.boolean  "author_deleted"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", :force => true do |t|
    t.integer  "user_id"
    t.string   "nickname"
    t.string   "ip_address"
    t.text     "message"
    t.integer  "chatroom_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "recipient_id"
    t.string   "sender_id"
    t.string   "recipient_room_id"
    t.string   "sender_room_id"
  end

  add_index "messages", ["chatroom_id"], :name => "index_messages_on_chatroom_id"
  add_index "messages", ["user_id"], :name => "index_messages_on_user_id"

  create_table "nodes", :force => true do |t|
    t.integer  "uid"
    t.integer  "vid"
    t.string   "content_type"
    t.string   "title"
    t.integer  "nid"
    t.integer  "status"
    t.integer  "f_created"
    t.integer  "f_changed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pageviews", :force => true do |t|
    t.integer  "views"
    t.string   "page_path"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "post_id"
    t.integer  "program_id"
    t.integer  "playlist_id"
  end

  create_table "permissions", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "photos", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "user_id"
    t.integer  "program_id"
    t.integer  "interview_id"
    t.integer  "review_id"
    t.integer  "post_id"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.text     "exif"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "photos", ["interview_id"], :name => "index_photos_on_interview_id"
  add_index "photos", ["program_id"], :name => "index_photos_on_program_id"
  add_index "photos", ["user_id"], :name => "index_photos_on_user_id"

  create_table "playlist_items", :force => true do |t|
    t.integer  "playlist_id"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "nid"
    t.integer  "track_id"
  end

  add_index "playlist_items", ["id"], :name => "index_playlist_items_on_id"
  add_index "playlist_items", ["playlist_id"], :name => "index_playlist_items_on_playlist_id"
  add_index "playlist_items", ["track_id"], :name => "index_playlist_items_on_track_id"

  create_table "playlists", :force => true do |t|
    t.integer  "program_id"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "nid"
    t.integer  "user_id"
  end

  add_index "playlists", ["id"], :name => "index_playlists_on_id"
  add_index "playlists", ["program_id"], :name => "index_playlists_on_program_id"
  add_index "playlists", ["user_id"], :name => "index_playlists_on_user_id"

  create_table "popular_this_weeks", :force => true do |t|
    t.integer  "user_id"
    t.integer  "program_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "nid"
    t.integer  "content_type_id"
    t.integer  "attachment_style"
  end

  add_index "posts", ["content_type_id"], :name => "index_posts_on_content_type_id"
  add_index "posts", ["id"], :name => "index_posts_on_id"
  add_index "posts", ["user_id"], :name => "index_posts_on_user_id"

  create_table "programs", :force => true do |t|
    t.string   "title"
    t.string   "genre_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "nid"
    t.text     "description"
    t.string   "thumb_file_name"
    t.string   "thumb_content_type"
    t.integer  "thumb_file_size"
    t.datetime "thumb_updated_at"
  end

  add_index "programs", ["genre_id"], :name => "index_programs_on_genre_id"
  add_index "programs", ["id"], :name => "index_programs_on_id"
  add_index "programs", ["user_id"], :name => "index_programs_on_user_id"

  create_table "reviews", :force => true do |t|
    t.string   "title"
    t.string   "content_type"
    t.integer  "genre_id"
    t.string   "artist_id"
    t.string   "album_id"
    t.string   "venue"
    t.string   "label_id"
    t.text     "body"
    t.string   "link"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "rating"
  end

  add_index "reviews", ["album_id"], :name => "index_reviews_on_album_id"
  add_index "reviews", ["artist_id"], :name => "index_reviews_on_artist_id"
  add_index "reviews", ["genre_id"], :name => "index_reviews_on_genre_id"
  add_index "reviews", ["id"], :name => "index_reviews_on_id"
  add_index "reviews", ["label_id"], :name => "index_reviews_on_label_id"
  add_index "reviews", ["user_id"], :name => "index_reviews_on_user_id"

  create_table "roles", :force => true do |t|
    t.string   "title"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["user_id"], :name => "index_roles_on_user_id"

  create_table "sections", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sections", ["title"], :name => "index_sections_on_title"

  create_table "stations", :force => true do |t|
    t.string   "station_name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "statuses", :force => true do |t|
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "announcement"
  end

  add_index "statuses", ["user_id"], :name => "index_statuses_on_user_id"

  create_table "strikes", :force => true do |t|
    t.text     "description"
    t.integer  "user_id"
    t.integer  "issued_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "strikes", ["issued_by"], :name => "index_strikes_on_issued_by"
  add_index "strikes", ["user_id"], :name => "index_strikes_on_user_id"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "tmp_catalogs", :force => true do |t|
    t.integer  "nid"
    t.string   "artist"
    t.string   "album"
    t.integer  "year"
    t.string   "label"
    t.integer  "number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tmp_playlist_tracks", :force => true do |t|
    t.string   "title"
    t.integer  "nid"
    t.integer  "weight"
    t.string   "artist"
    t.string   "album"
    t.string   "label"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tmp_reviews", :force => true do |t|
    t.integer  "uid"
    t.string   "name"
    t.string   "email"
    t.integer  "nid"
    t.integer  "field_rating_value"
    t.text     "field_review_value"
    t.string   "field_artist_value"
    t.string   "field_album_value"
    t.string   "field_record_label"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tmp_revisions", :force => true do |t|
    t.integer  "nid"
    t.integer  "vid"
    t.integer  "uid"
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tmp_tables", :force => true do |t|
    t.string  "artist"
    t.integer "schedule_nid"
    t.integer "iid"
    t.integer "program_id"
    t.integer "starts_at"
    t.integer "finish"
    t.integer "may_archive"
  end

  create_table "top_djs", :force => true do |t|
    t.integer  "user_id"
    t.integer  "program_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tracks", :force => true do |t|
    t.string   "title"
    t.integer  "album_id"
    t.integer  "artist_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "t_number"
  end

  add_index "tracks", ["album_id"], :name => "index_tracks_on_album_id"
  add_index "tracks", ["artist_id"], :name => "index_tracks_on_artist_id"
  add_index "tracks", ["id"], :name => "index_tracks_on_id"

  create_table "tweets", :force => true do |t|
    t.text     "body"
    t.text     "tid"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tweets", ["user_id"], :name => "index_tweets_on_user_id"

  create_table "unique_objs", :force => true do |t|
    t.string   "title"
    t.string   "description"
    t.string   "objectifiable_type"
    t.integer  "objectifiable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_groups", ["id"], :name => "index_user_groups_on_id"
  add_index "user_groups", ["name"], :name => "index_user_groups_on_name"

  create_table "user_groups_users", :id => false, :force => true do |t|
    t.integer "user_group_id"
    t.integer "user_id"
  end

  add_index "user_groups_users", ["user_group_id", "user_id"], :name => "index_user_groups_users_on_user_group_id_and_user_id"
  add_index "user_groups_users", ["user_id", "user_group_id"], :name => "index_user_groups_users_on_user_id_and_user_group_id"

  create_table "users", :force => true do |t|
    t.string   "f_name"
    t.string   "l_name"
    t.string   "signature"
    t.string   "email"
    t.text     "about"
    t.string   "influences"
    t.string   "dj_name"
    t.string   "homepage"
    t.integer  "age"
    t.string   "gender"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.string   "single_access_token"
    t.string   "perishable_token"
    t.integer  "login_count"
    t.integer  "failed_login_count"
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.integer  "nid"
    t.string   "role"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.boolean  "listener"
    t.string   "image_remote_url"
    t.string   "chatroom_id"
    t.text     "phone"
    t.string   "nickname"
    t.string   "twitter_username"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["perishable_token"], :name => "index_users_on_perishable_token"

  create_table "views", :force => true do |t|
    t.string   "viewable_type"
    t.integer  "viewable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_agent"
  end

  add_index "views", ["id"], :name => "index_views_on_id"
  add_index "views", ["viewable_id", "viewable_type"], :name => "index_views_on_viewable_id_and_viewable_type"

  create_table "volunteer_hours", :force => true do |t|
    t.integer  "user_id"
    t.text     "description"
    t.string   "v_type"
    t.integer  "hours"
    t.datetime "v_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "approved"
  end

  add_index "volunteer_hours", ["user_id"], :name => "index_volunteer_hours_on_user_id"

end
