class Person < ActiveRecord::Base
  has_one :user
  has_many :contacts
  has_many :sales

  validates_uniqueness_of :document_id, :message => "Ya existe un cliente con ese numero de cedula."

  def name_and_doc
    p = Person.find_by_document_id document_id
    "#{p.name}, #{p.document_id}"
  end
end
