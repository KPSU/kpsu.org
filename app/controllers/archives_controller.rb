class ArchivesController < ApplicationController
  layout 'alternative'
  respond_to :json, :js, :html
  
  
  def index
    @downloads = Download.paginate(:all, :order => 'title DESC', :conditions => ['program_id > ?', 0], :include => [:user, :program], :page => params[:page], :per_page => 25)
  end
  
  def list
    uri = URI.parse("http://archive.kpsu.org/rss.xml")
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    feed = Crack::XML.parse(response.body)
    @archive = JSON.parse("feed.to_json}")
    respond_to do |format|
      format.json { render :partial => "archives/list.json.erb" }
    end
  end
  
  def search
    if params[:download]  
      if params[:download][:program] 
        @program = params[:download][:program]
        @search = @program
      end
      
      if params[:download][:dj]
        @dj = params[:download][:dj]
        @search = @dj
      end
      if @program.size > 0
        @downloads = Download.program_title_like(params[:download][:program]).paginate(:page => params[:page], :order => 'created_at DESC')
        @downloads.sort! {|x,y| x.title.to_i <=> y.title.to_i }
        @downloads.reverse!
      elsif @dj.size > 0      
        @downloads = Download.user_dj_name_like(params[:download][:dj]).paginate(:page => params[:page], :order => 'created_at DESC')
        @downloads.sort! {|x,y| x.title.to_i <=> y.title.to_i }
        @downloads.reverse!
      end
    end
    
    unless params[:download]
      if params[:program] 
        @program = params[:program]
        @search = @program
      end
      if params[:dj] 
        @dj = params[:dj]
        @search = @dj
      end
      if @program.size > 0
        @downloads = Download.program_title_like(params[:program]).paginate(:page => params[:page], :order => 'created_at DESC')
        @downloads.sort! {|x,y| x.title.to_i <=> y.title.to_i }
        @downloads.reverse!
      elsif @dj.size > 0      
        @downloads = Download.user_dj_name_like(params[:dj]).paginate(:page => params[:page], :order => 'created_at DESC')
        @downloads.sort! {|x,y| x.title.to_i <=> y.title.to_i }
        @downloads.reverse!
      end
    end
    
    if @downloads.size == 0
      flash[:error] = "No results found, please try being more specific"
    end
  end
  
end
