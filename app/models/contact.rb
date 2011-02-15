class Contact < ActiveRecord::Base
  has_many :comments
  has_many :answers
  
  validates_presence_of :nickname, :email
end
