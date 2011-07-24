class Size < ActiveRecord::Base
  has_many :products
  validates_presence_of :size, :message => 'Ingrese la talla.'
  validates_uniqueness_of :size, :case_sensitive => false, :message => 'La talla ya existe.'
end

# == Schema Information
#
# Table name: sizes
#
#  id         :integer(4)      not null, primary key
#  size       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

