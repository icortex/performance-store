class Brand < ActiveRecord::Base
  validates_presence_of :brand, :message => 'Ingrese el nombre de la marca.'
  validates_uniqueness_of :brand, :case_sensitive => false, :message => 'La marca ya existe.'
end

# == Schema Information
#
# Table name: brands
#
#  id         :integer(4)      not null, primary key
#  brand      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

