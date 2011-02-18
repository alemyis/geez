module ApplicationHelper
  #TODO: deal with optiization later on
  def self.get_value(key, returnValueIfNull)
    #init if null
    value = Lookup.find_by_key(key)
    
    return value.nil? ? returnValueIfNull : value.value
  end
end
