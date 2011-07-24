class Lot < ActiveRecord::Base
  validates_numericality_of :freight, :message => 'El flete debe ser un numero.'
end

# == Schema Information
#
# Table name: lots
#
#  id           :integer(4)      not null, primary key
#  arrival_date :date
#  freight      :integer(4)
#  carrier      :string(255)
#  origin       :string(255)
#  weight       :integer(4)
#  total_cost   :integer(4)
#  created_at   :datetime
#  updated_at   :datetime
#

