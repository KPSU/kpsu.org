Kpsu::Application.routes.draw do

  match '/auth/:provider/callback' => 'authentications#create' 
  root :to => "posts#index"
  match '/posts/user/:id' => "posts#user_posts", :as => "users_posts" 
  match '/listen' => "contents#view", :as => :listen, :title => "listen"
  #match '/calendar(/:year(/:month))' => 'calendar#index', :as => :calendar, :constraints => {:year => /\d{4}/, :month => /\d{1,2}/}
  match '/about' => "contents#view", :as => :about, :title => "About KPSU"
  match '/reset_password' => 'password_resets#edit'
  match '/em_show/:id' => 'artists#em_show'
  match '/catalogs/search/' => "catalogs#search", :as => "catalog_search"
  match '/archives/search/' => "archives#search", :as => "archive_search"
  match '/users/feed' => 'users#feed', :as => "feed"
  match '/volunteer_hours/:id/approve' => 'volunteer_hours#approve', :as => "vh_approve"
  match '/volunteer_hours/:id/deny' => 'volunteer_hours#deny', :as => "vh_deny"
  match '/volunteer_hours/:id/respond' => 'volunteer_hours#respond', :as => "vh_respond"
  match 'tweet' => 'twitter#tweet', :as => 'tweet'
  match '/users/:id/blogs' => 'users#blogs', :as => 'user_blogs'
  match '/posts/pageless' => 'posts#pageless_posts', :as => 'pageless_posts'
  match '/playlists/new/search' => 'playlists#search', :as => "create_playlist_search"
  match '/messages/send_message' => 'messages#send_message', :as => "send_message"
  match '/happenings/find' => 'happenings#find', :as => "find_happening"
  match '/programs/program_manager_edit/:id' => 'programs#program_manager_edit', :as => "program_manager_edit"
  match '/strikes/user_search' => 'strikes#user_search', :as => "strike_user_search"
  match '/strikes/user_lookup' => 'strikes#user_lookup', :as => "strike_user_lookup"
  match '/site/featured_artists' => 'site#featured_artist', :as => "featured_artists_mgmt"
  match '/programs/all' => 'programs#public_index', :as => "program_index"
  match '/users/stats' => 'users#stats', :as => "stats"
  match '/station/directory' => 'users#directory', :as => "station_directory" # this is a directory of users (not listeners) at the station
  


  resources :playlists do
    get :autocomplete_artist_name, :on => :collection
    get :autocomplete_album_name, :on => :collection
    get :autocomplete_program_title, :on => :collection
    get :autocomplete_track_title, :on => :collection
    get :autocomplete_label_name, :on => :collection
  end
  resources :tracks
  resources :statuses
  resources :artists
  resources :authentications
  resources :contents
  resources :comments
  resources :events
  resources :strikes
  resources :sections
  resources :happenings
  resources :mails
  resources :catalogs

  resources :programs
  
  resources :interviews
  
  resources :photos

  resources :posts
  resources :volunteer_hours
  resources :reviews do
    get :autocomplete_artist_name, :on => :collection
    get :autocomplete_album_name, :on => :collection
    get :autocomplete_program_title, :on => :collection
    get :autocomplete_track_title, :on => :collection
    get :autocomplete_label_name, :on => :collection
  end

  resources :genres
  resources :assets
  resources :handbook_pages
  resources :dj_handbook, :controller => "handbook_pages"
  resources :password_resets
  resources :user_sessions
  resources :archives  
  resources :messages
  resources :chatrooms
  resources :blogs, :controller => "posts", :blog => true
  resources :reviews, :controller => "posts", :review => true
  resources :schedules, :controller => "schedules"
  resources :media, :controller => "assets"
  
  match '/users/volunteer_hours' => 'users#volunteer_hours', :as => "vh"
  match '/schedule/timeslot_availability' => 'schedules#timeslot_availability', :as => "timeslot_availability"
  match '/schedule' => 'schedules#index', :as => "schedule"
  match '/schedule/edit' => 'schedules#edit', :as => "schedule_edit"
  match '/donate' => "contents#view", :as => "donate", :id => 10
  match '/djs' => "users#index", :as => "djs", :dj => "1"
  match '/contents/view/:id' => "contents#view"
  match '/inbox' => 'mails#index', :as => :mail, :folder => 'inbox'
  match 'kpsu_twitter' => "twitter#kpsu_recent_tweets", :as => :recent_tweets
  match 'login' => 'user_sessions#new', :as => "login"
  match 'logout' => 'user_sessions#destroy', :as => "logout"
  match 'popup_player' => 'site#popup_player', :as => "popup_player"
  match 'archive/list' => 'archives#list'
  match 'dashboard' => 'users#dashboard', :as => "dashboard"
  match 'contact' => "contents#view", :as => "contact", :title => "contact"
  match 'underwriting' => "contents#view", :as => "underwriting", :title => "underwriting"
  match 'download' => "programs#download", :as => "download"
  match '/users/:id/downloads' => "users#downloads", :as => "user_downloads"
  match '/downloads/:id/destroy' => "users#destroy_download", :as => "remove_download"
  match '/downloads/:id/own' => "users#own_download", :as => "own_download"
  match '/listener/settings' => "users#listener_settings", :as => "listener_settings"
  match '/listener/:id/edit' => "users#listener_edit", :as => "listener_edit"
  match '/listener/:id/update' => "users#listener_update", :as => "listener_update"
  resources :users do
    resources :blogs, :controller => "posts", :blog => true
    resources :playlists
  end
  match '/listener/home' => "users#listener", :as => "listener"
  match '/comments/:type/:id' => "comments#index", :as => "content_comment"
  match '/program/:title' => "programs#show"
  match '/auth/:provider' => 'authentications#passthru'



  get "/:page" => "static#show"
  #as per http://stackoverflow.com/questions/5911794/adding-a-new-page-in-ruby-on-rails
  #in conjunction with building a semi-static calendar view page (under app/views/static)
  #it was important that the error routing take place after this, as it defines everything not defined above it to get
  #re-routed to a 404 page.

  match '*a', :to => 'errors#routing'



  # Route globbing FTW for DJ lookup
  
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'


end
