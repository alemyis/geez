class ChallengesController < ApplicationController
  # GET /challenges
  # GET /challenges.xml
  def index
    page_size = params[:size].nil? ? 1 : params[:size].to_i
    @page = params[:page] == 'rand' ? rand(Challenge.all.count).to_i : params[:page].to_i 
    @page = 1 if @page < 1
    @challenges = Challenge.all.paginate(:per_page => page_size, :page => @page)
    @fetan = session[:fetan].nil? || session[:fetan] #default to fetan on
    @admin = !params[:admin].nil?
    
    # for the active once - init answers
    for challenge in @challenges do
      if challenge.status == 1 then
        for categorization in challenge.categorizations do
          categorization.answers.build(:contact_id => 1)
        end
      end
    end 
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @challenges }
    end
  end

  # GET /challenges/1
  # GET /challenges/1.xml
  def show
    redirect_to :action => 'index', :page => params[:id]
  end

  # GET /challenges/new
  # GET /challenges/new.xml
  def new
    @challenge = Challenge.new
    5.times do 
      categorization = @challenge.categorizations.build 
    end 
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @challenge }
    end
  end

  # GET /challenges/1/edit
  def edit
    @challenge = Challenge.find(params[:id])
  end

  # POST /challenges
  # POST /challenges.xml
  def create
    @challenge = Challenge.new(params[:challenge])

    respond_to do |format|
      if @challenge.save
        format.html { redirect_to(@challenge, :notice => 'Challenge was successfully created.') }
        format.xml  { render :xml => @challenge, :status => :created, :location => @challenge }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @challenge.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /challenges/1
  # PUT /challenges/1.xml
  def update
    @challenge = Challenge.find(params[:id])

    # Create if contact is not found 
    contact = Contact.find_or_create_by_nickname_and_email_and_phone_and_fbuid(params[:contact]) 
    
    # Major hack. Tweak contact_id parameter for answer object. Use ID from the above contact
    params[:challenge][:categorizations_attributes].each_value do |category_value|
      unless category_value[:answers_attributes].nil? then
        category_value[:answers_attributes].each_value do |answer_value| 
          if answer_value.has_key? :contact_id then
            answer_value[:contact_id] = contact.id.to_s
          end
        end
      end
    end #category_value

    respond_to do |format|
      if @challenge.update_attributes(params[:challenge])
        format.html { redirect_to(@challenge, :notice => 'Challenge was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { redirect_to(@challenge, :error => 'Unsuccessful submission.') }
        format.xml  { render :xml => @challenge.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /challenges/1
  # DELETE /challenges/1.xml
  def destroy
    @challenge = Challenge.find(params[:id])
    @challenge.destroy

    respond_to do |format|
      format.html { redirect_to(challenges_url) }
      format.xml  { head :ok }
    end
  end
end
