class SaleProduct < ActiveRecord::Base

  attr_accessor :reference, :size, :color
  attr_accessible :product_id,:quantity,:price

  belongs_to :sale
  belongs_to :product

end
