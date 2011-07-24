class Stock < ActiveRecord::Base
  belongs_to :product
  belongs_to :headquarter
  validates_uniqueness_of :product_id, :scope => :headquarter_id,
                          :message => "El articulo ya esta en el inventario de esta sede."

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

