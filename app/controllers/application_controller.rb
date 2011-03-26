class ApplicationController < ActionController::Base
  protect_from_forgery :except => :fbcanvas
  
  def fetan
    if session[:fetan].nil? || session[:fetan] == false then 
      session[:fetan] = true
    else
      session[:fetan] = false
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
end
