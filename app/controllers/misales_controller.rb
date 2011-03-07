class MisalesController < ApplicationController
  # GET /misales
  # GET /misales.xml
  def index
    @page_size = params[:size].nil? ? 1 : params[:size].to_i
    @fetan = !session[:fetan].nil?
    @misales = Misale.search(params[:search]).paginate(:per_page => @page_size, :page => params[:page])
    
    
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
    @fetan = !session[:fetan].nil?
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
    
    # Create if contact is not found 
    contact = Contact.find_or_create_by_nickname_and_email_and_phone_and_fbuid(params[:contact]) 
    
    # Hack - Tweak contact id with the one fetched or created above.
    unless params[:misale][:comments_attributes].nil? then
      params[:misale][:comments_attributes].each_value do |comment_value|
        if contact.new_record? then #invalid contact info provided, remove comment so it won't be saved
          comment_value[:comment] = nil
        elsif comment_value.has_key? :contact_id then
          comment_value[:contact_id] = contact.id.to_s
        end
      end      
    end
    
    respond_to do |format|
      if @misale.update_attributes(params[:misale])
        format.html { redirect_to(@misale, :notice => 'Misale was successfully updated.') }
        format.xml  { head :ok }
      else
        # TODO - once we have admin/non-admin users defined, redirect based on rights.
        format.html { render :action => "show" }
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
  
  def fbpost
    @misale = Misale.find(params[:id])
    #@misale.ye = 
    puts @misale.ye
    @misale.ye = @misale.ye.nil? ? 1 : 1 + @misale.ye
    @misale.save
    
    puts @misale.ye
    render  'fbpost'
  end
    
  def home
    respond_to do |format|
      format.html # index.html.erb
      #format.xml  { render :xml => @misales }
    end
  end
end
