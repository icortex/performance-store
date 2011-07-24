class Variable < ActiveRecord::Base
  validates_numericality_of :value, :message => 'Por favor, ingrese un valor correcto.'
end

# == Schema Information
#
# Table name: variables
#
#  id         :integer(4)      not null, primary key
#  key        :string(255)
#  value      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

