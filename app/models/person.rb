class Person < ActiveRecord::Base
  has_one :user
  has_many :contacts
  has_many :sales

  validates_uniqueness_of :document_id, :message => "Ya existe un cliente con ese numero de cedula."
end
