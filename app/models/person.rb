class Person < ActiveRecord::Base
  has_one :user
  has_many :contacts
end
