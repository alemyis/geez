module ApplicationHelper
  #TODO: deal with optiization later on
  def self.get_value(key, returnValueIfNull)
    #init if null
    value = Lookup.find_by_key(key)
    
    return value.nil? ? returnValueIfNull : value.value
  end
  
  def self.FB_APP_ID
    '6d47a544aaee664209ae9d0666aa8e39'
  end 
  
  def self.FB_CANVAS
    'http://50.16.134.117:90'
  end
end
