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

# == Schema Information
#
# Table name: people
#
#  id          :integer(4)      not null, primary key
#  name        :string(255)
#  birthday    :date
#  document_id :string(255)
#  gender      :string(255)
#  phone       :string(255)
#  mobile      :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  email       :string(255)
#

