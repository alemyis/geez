class ApplicationController < ActionController::Base
  protect_from_forgery :except => :fbcanvas
  
  def fetan
    if session[:fetan].nil? || session[:fetan] == true then 
      session[:fetan] = false
    else
      session[:fetan] = true
    end
    
    render :text => {:fetan => session[:fetan]}
    
  end
  
  def fbcanvas
    if(params[:fbpost].nil?) then
      redirect_to :controller => 'misales', :action => 'home'
    else 
      #redirect_to :controller => 'misales', :action => 'fbpost'
      @misale = Misale.find(params[:fbpost])

      @misale.ye = @misale.ye.nil? ? 1 : 1 + @misale.ye
      @misale.save
    
      render  :partial => '/misales/unload'
    end
  end
  
  def tweet
    # Certain methods require authentication. To get your Twitter OAuth credentials,
    # register an app at http://dev.twitter.com/apps
    Twitter.configure do |config|
    end

    # Initialize your Twitter client
    client = Twitter::Client.new

    # Post a status update
    client.update(params[:message], {:lat => params[:lat], :long => params[:long]})
    
    render :text => 'done'
  end
end
