class Categorization < ActiveRecord::Base
  belongs_to :misale
  belongs_to :challenge
  has_many :answers
  
  #validates_presence_of :misale_id, :challenge_id, :position
  #validates_presence_of :answers

  #accepts_nested_attributes_for :answers, :reject_if => lambda { |a| a[:email].blank? || a[:nickname].blank? || a[:response].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :answers, :reject_if => lambda { |a| a[:response].blank? }, :allow_destroy => true
  
  
  #validates_associated :answers
end
