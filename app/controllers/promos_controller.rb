class PromosController < ApplicationController
  layout 'alternative'
  before_filter :require_user, :only => ['new', 'edit', 'destroy', 'update', 'create']
  before_filter :no_listener, :only => ['new', 'edit', 'destroy', 'update', 'create']
  before_filter :is_staff, :only => ['new', 'edit', 'destroy', 'update', 'create']
  before_filter :has_profile_filled_out

  # GET /promos
  # GET /promos.xml
  def index
    @promos = Promo.all
    @promopromos = Promo.where(:category => 1)
    @promopromos.sort!{|x,y| x.title <=> y.title}
    @psapromos = Promo.where(:category => 2)
    @psapromos.sort!{|x,y| x.title <=> y.title}
    @psatimelypromos = Promo.where(:category => 3)
    @psatimelypromos.sort!{|x,y| x.title <=> y.title}

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @promos }
    end
  end

  # GET /promos/1
  # GET /promos/1.xml
  def show
    @promo = Promo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @promo }
    end
  end

  # GET /promos/new
  # GET /promos/new.xml
  def new
    @promo = Promo.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @promo }
    end
  end

  # GET /promos/1/edit
  def edit
    @promo = Promo.find(params[:id])
  end

  # POST /promos
  # POST /promos.xml
  def create
    @promo = Promo.new(params[:promo])
    @promo.count = 0
    @category = params[:category]
    @promo.category = @category
    @promo.save

    respond_to do |format|
      if @promo.save
        format.html { redirect_to(promos_url, :notice => 'Promo was successfully created.') }
        format.xml  { render :xml => @promo, :status => :created, :location => @promo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @promo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /promos/1
  # PUT /promos/1.xml
  def update
    @promo = Promo.find(params[:id])

    respond_to do |format|
      if @promo.update_attributes(params[:promo])
        format.html { redirect_to(@promo, :notice => 'Promo was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @promo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /promos/1
  # DELETE /promos/1.xml
  def destroy
    @promo = Promo.find(params[:id])
    @promo.delete
    @promo.save

    respond_to do |format|
      format.html { redirect_to(promos_url) }
      format.xml  { head :ok }
    end
  end
end
