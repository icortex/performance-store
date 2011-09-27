class Stock < ActiveRecord::Base
  belongs_to :product
  belongs_to :headquarter
  belongs_to :lot_product

  before_save :set_unassigned_qty
  before_destroy :sum_lot

  private
  def sum_lot
    new_quantity=old_quantity+self.quantity
    self.lot_product.update_attribute(:unassigned_quantity,new_quantity)
  end

  def set_unassigned_qty
    old_stock_quantity= (Stock.find self.id).quantity rescue 0
    delta_stock_quantity=self.quantity-old_stock_quantity
    new_quantity=old_quantity-delta_stock_quantity
    self.lot_product.update_attribute(:unassigned_quantity,new_quantity)
  end

  def old_quantity
    LotProduct.find(self.lot_product_id).unassigned_quantity
  end

end

# == Schema Information
#
# Table name: stocks
#
#  id             :integer(4)      not null, primary key
#  product_id     :integer(4)
#  quantity       :integer(4)
#  price          :integer(4)
#  headquarter_id :integer(4)
#  created_at     :datetime
#  updated_at     :datetime
#  cost           :integer(4)
#

