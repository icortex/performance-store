class LotProduct < ActiveRecord::Base

  attr_accessor :reference, :size, :color
  attr_accessible :product_id, :quantity, :cost,:utility
  
  belongs_to :lot
  belongs_to :product
end
