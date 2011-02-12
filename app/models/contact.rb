class Contact < ActiveRecord::Base
  has_many :comments
  has_many :answers
end
