class Lot < ActiveRecord::Base
  validates_numericality_of :freight, :message => 'El flete debe ser un numero.'
  validates_presence_of :arrival_date, :message => 'Por favor, ingrese la fecha de llegada del lote.'

  has_many :lot_products, :dependent => :destroy
  has_many :products, :through => :lot_products
  accepts_nested_attributes_for :lot_products,
                                :allow_destroy => true, :reject_if => lambda { |lp|
       lp[:product_id].blank? || lp[:quantity].blank? || lp[:quantity] == '0'
      }
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

