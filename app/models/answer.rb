class Answer < ActiveRecord::Base
  belongs_to :categorization
  belongs_to :contact
  
  validates_presence_of :contact_id, :categorization_id, :response
end
