class AbstractUsersController < ApplicationController
	
	def get_users_by_genre(genre)
    	@genre = Genre.includes(:programs => [:user => [:downloads]]).find(params[:genre])
   		@users = @genre.programs.collect{|program| if program.event; program.user; end;}
    	return @genre, @users
  	end

	def get_djs
	    @users = Event.includes(:program => [:user => [:downloads]]).collect do |e|
	      unless RAILS_ENV == "development"
	        if e.program.user && e.program.user.avatar.exists? && e.program.user.downloads.size >= 1
	          e.program.user 
	        end
	      else
	        if !e.program.user.avatar.exists? && e.program.user.downloads.size >= 1
	          e.program.user 
	        end
	      end
	    end.compact
  	end


  	def get_top_djs
  
	    @month, @week, @users = Date.today-1.month, Date.today-1.week, User.all
	  
	    @most_popular = @users.sort{|x,y| x.profile_views <=> y.profile_views }
	    @most_downloads = @users.sort{|x,y| x.total_downloads_within(@month) <=> y.total_downloads_within(@month) }
	    @most_popular_week = @users.sort{|x,y| x.profile_views_within(@week) <=> y.profile_views_within(@week) }
	  
		return @most_popular, @most_downloads, @most_popular_this_week
	  
	end

	def paginate_index(page=1, per_page=30, users_array)
	    users_array.instance_eval do
			def paginate(page=1, per_page=10)
				Rails.logger.debug(page)
				WillPaginate::Collection.create(page, per_page, size) do |pager|
					pager.replace self[pager.offset, pager.per_page].to_a
				end
			end
		end
		users_array.paginate(page, per_page)
	end
  
  	def increment_visit 
    	if @u
	        @v = View.new
	        @v.viewable = @u
	        @v.user_agent = request.user_agent
	        @v.save
     	end
  	end

  	def destroy_download
    	@download = Download.find(params[:id])
	    if @download.user == current_user
	      @download.user = nil
	      @download.program = nil
	      if @download.save
	        @user = current_user
	        respond_to do |format|
	          format.js { render :partial => "my_downloads" }
	        end
	      else
	        respond_to do |format|
	          format.js { render :partial => "own_download_error.js.erb" }
	        end
	      end
	    end
  	end
  
  	def own_download
	    @download = Download.find(params[:id])
	    if params[:program_id]
	      @program = Program.find(params[:program_id])
	    else
	      @program = current_user.programs.first
	    end
	    Rails.logger.info @download.id
	    if @download
		    @download.user = current_user
		    @download.program = @program   
		    if @download.save
	        	@user = current_user
	        	respond_to do |format|
	          		format.js { render :partial => "my_downloads" }
	        	end
	      	else
		        respond_to do |format|
		          format.js { render :partial => "own_download_error.js.erb" }
		        end
	      	end
	    end
  	end
  
	def downloads
	   	@user = User.find(params[:id])
	   	@orphans = Download.find_all_by_user_id(nil)
	   	@latest = Download.find(:all, :order => 'created_at DESC', :limit => 24)
	   	respond_to do |format|
	     	format.js {render :partial => "downloads"}
	   	end
	end
  
	def stats
		respond_to do |format|
	    	format.js {render :partial => "stats" }
		end
	end

end