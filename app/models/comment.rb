class Comment < ActiveRecord::Base
  belongs_to :misale
  #belongs_to :contact
  
  #accepts_nested_attributes_for :contact, :reject_if => lambda { |a| a[:email].blank? || a[:nickname].blank? }, :allow_destroy => true
end
