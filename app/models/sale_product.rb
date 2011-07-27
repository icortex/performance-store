class SaleProduct < ActiveRecord::Base

  attr_accessor :reference, :size, :color
  attr_accessible :product_id, :quantity, :price

  belongs_to :sale
  belongs_to :product

  validates_presence_of :product_id, :message => 'Debe especificar el producto que va a vender!'
  validates_numericality_of :quantity, :price, :greater_than => 0, :message => 'debe ser un numero!'
end

# == Schema Information
#
# Table name: sale_products
#
#  id         :integer(4)      not null, primary key
#  sale_id    :integer(4)
#  product_id :integer(4)
#  quantity   :integer(4)
#  price      :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

