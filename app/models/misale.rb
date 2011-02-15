class Misale < ActiveRecord::Base
  has_many :comments
  has_many :categorizations
  has_many :chanllenges, :through => :categorizations
  has_many :answers, :through => :categorizations
  
  validates_presence_of :head, :tail #, :comments
  
  accepts_nested_attributes_for :comments, :reject_if => lambda { |a| a[:comment].blank? }, :allow_destroy => true

  
  def name
    "#{self.head} #{self.tail}"
  end
end
