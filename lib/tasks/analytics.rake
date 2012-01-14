
namespace :analytics do
  desc "Build daily traffic reports"
  task :top_djs => :environment do
    
    @size = User.all.size

    ## Top DJ for the week
    ## User.rb contains the calculation process

    @top_dj = User.all.sort{|x,y| x.dj_score <=> y.dj_score }
    @top = @top_dj.last
    @t_new = TopDj.new
    @t_new.user = @top
 	@t_new.save

 	## Download Champ for the week (most downloads)
 	
 	@one_week = Date.today-1.week
 	@download_champ = User.all.sort{|x,y| x.total_downloads_within(@one_week) <=> y.total_downloads_within(@one_week) }

 	@dc = DownloadChamp.new

 	## Just because it looks a little weird having the same person sweep all the top metrics
 	## and probably lowers morale... there is filter, to make sure no person takes multiple
 	## top spots.

 	if @dc.user == @t_new.user
 		@dc.user = @download_champ[(@size-1)]
 	end
 	@dc.user = @download_champ.last
 	@dc.save

 	## Most popular this week

 	@popular = User.all.sort{|x,y| x.popularity_score <=> y.popularity_score }
 	@popular_this_week = PopularThisWeek.new

 	## Same as the previous check for duplicates in the top metrics,
 	## but it performs the check twice to make sure neither the top dj
 	## or download champ are the popular dj.

 	if @dc.user == @popular.last || @t_new.user == @popular.last
 		@popular_this_week.user = @popular[(@size-1)]
 		if @popular_this_week.user == @dc.user || @popular_this_week.user == @t_new.user
 			@popular_this_week.user = @popular[(@size-2)]
 		end
 	else
 		@popular_this_week.user = @popular.last
 	end
 	@popular_this_week.save

  end
end