class Misale < ActiveRecord::Base
  has_many :comments
  has_many :categorizations
  has_many :chanllenges, :through => :categorizations
  has_many :answers, :through => :categorizations
 
  accepts_nested_attributes_for :comments, :reject_if => lambda { |a| a[:email].blank? || a[:nickname].blank? || a[:comment].blank? }, :allow_destroy => true

  
  def name
    "#{self.head} #{self.tail}"
  end
end
