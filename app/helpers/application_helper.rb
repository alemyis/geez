module ApplicationHelper
  #TODO: deal with optiization later on
  def self.get_value(key, returnValueIfNull)
    #init if null
    value = Lookup.find_by_key(key)
    
    return value.nil? ? returnValueIfNull : value.value
  end
  
  def self.FB_APP_ID
    '196575340361945'
  end 
  
  def self.FB_CANVAS
    'http://www.geezchewata.com'
  end
  
  def self.FB_CANVAS_PAGE
    'http://apps.facebook.com/geezchewata'
  end
  
  def self.APPLICATION_NAME
    "&#x130D;&#x12D5;&#x12DD &#x1328;&#x12CB;&#x1273;(Ge'ez chewata)"
  end
end
