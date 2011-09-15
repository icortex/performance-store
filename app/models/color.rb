class Color < ActiveRecord::Base
  has_many :product
  validates_length_of :rgb, :within => 3..6, :message => "Por favor, verifica el codigo RGB."
  validates_presence_of :rgb, :message => 'Ingrese el codigo del color.'
  validates_uniqueness_of :rgb, :case_sensitive => false, :message => 'El color ya existe.'
end

# == Schema Information
#
# Table name: colors
#
#  id         :integer(4)      not null, primary key
#  color      :string(255)
#  created_at :datetime
#  updated_at :datetime
#  rgb        :string(255)
#

