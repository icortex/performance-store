class Headquarter < ActiveRecord::Base
  validates_presence_of :name, :message => 'Ingrese el nombre de la sede.'
  validates_uniqueness_of :name, :case_sensitive => false, :message => 'La sede ya existe.'
end

# == Schema Information
#
# Table name: headquarters
#
#  id          :integer(4)      not null, primary key
#  name        :string(255)
#  address     :string(255)
#  phone       :string(255)
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

