class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def fetan
    if session[:fetan].nil? then 
      session[:fetan] = true
    else
      session[:fetan] = nil
    end
    
    render :text => {:fetan => session[:fetan]}
    
  end
  
end
