class Stock < ActiveRecord::Base
  belongs_to :product
  belongs_to :headquarter
  validates_uniqueness_of :product_id, :scope => :headquarter_id
end
