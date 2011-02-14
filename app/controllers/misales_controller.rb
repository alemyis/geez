class MisalesController < ApplicationController
  # GET /misales
  # GET /misales.xml
  def index
    @page_size = params[:size].nil? ? 1 : params[:size].to_i
    @misales = Misale.all.paginate(:per_page => @page_size, :page => params[:page])

    # for the new once create a comment object
    for misale in @misales do
      misale.comments.build
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @misales }
    end
  end

  # GET /misales/1
  # GET /misales/1.xml
  def show
    @misale = Misale.find(params[:id])
    
    @comment = @misale.comments.build
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @misale }
    end
  end

  # GET /misales/new
  # GET /misales/new.xml
  def new
    @misale = Misale.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @misale }
    end
  end

  # GET /misales/1/edit
  def edit
    @misale = Misale.find(params[:id])
  end

  # POST /misales
  # POST /misales.xml
  def create
    @misale = Misale.new(params[:misale])

    respond_to do |format|
      if @misale.save
        format.html { redirect_to(@misale, :notice => 'Misale was successfully created.') }
        format.xml  { render :xml => @misale, :status => :created, :location => @misale }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @misale.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /misales/1
  # PUT /misales/1.xml
  def update
    @misale = Misale.find(params[:id])

    respond_to do |format|
      if @misale.update_attributes(params[:misale])
        format.html { redirect_to(@misale, :notice => 'Misale was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @misale.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /misales/1
  # DELETE /misales/1.xml
  def destroy
    @misale = Misale.find(params[:id])
    @misale.destroy

    respond_to do |format|
      format.html { redirect_to(misales_url) }
      format.xml  { head :ok }
    end
  end
end
