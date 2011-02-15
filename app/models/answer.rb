class Answer < ActiveRecord::Base
  belongs_to :categorization
  belongs_to :contact
  
  validates_presence_of :contact_id, :categorization_id, :response
  
  accepts_nested_attributes_for :contact, :reject_if => lambda { |a| a[:nickname].blank? || a[:email].blank? }, :allow_destroy => true
end
