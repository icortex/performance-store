class Separate < ActiveRecord::Base

  belongs_to :sale
  validates_numericality_of :payment, :message => 'Por favor, ingrese el monto del abono.'
  
end

# == Schema Information
#
# Table name: separates
#
#  id         :integer(4)      not null, primary key
#  sale_id    :integer(4)
#  payment    :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

