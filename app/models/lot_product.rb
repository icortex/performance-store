class LotProduct < ActiveRecord::Base

  attr_accessor :reference, :size, :color, :headquarter_id
  attr_accessible :product_id, :quantity, :cost,:cost_cop,:sales_cost,:price,:unassigned_quantity,:utility
  
  belongs_to :lot
  belongs_to :product
  has_many :stocks, :dependent => :destroy
end
