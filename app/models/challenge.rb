class Challenge < ActiveRecord::Base
  has_many :categorizations #, :dependent => :destroy
  has_many :misales, :through => :categorizations
  
  accepts_nested_attributes_for :categorizations, :reject_if => lambda { |a| a[:misale_id].blank? || a[:position].blank? }, :allow_destroy => true
  
  def get_status
    case self.status
      when 0 then 'Created'
      when 1 then 'Active'
      when 2 then 'Closed'
    end
  end
  
  CREATED = 0
  ACTIVE = 1
  CLOSED = 2
end
