class Sale < ActiveRecord::Base

  belongs_to :person
  belongs_to :headquarter
  
  has_many :sale_products, :dependent => :destroy
  has_many :products, :through => :sale_products
  accepts_nested_attributes_for :sale_products, :reject_if => lambda { |sp| sp[:reference].blank? },
                                                :allow_destroy => true

  after_save :update_stock

  def update_stock
    self.sale_products.each do |sp|
      stock = Stock.where('product_id = ? and headquarter_id = ?', sp.product_id, self.headquarter_id)[0]
      new_qty = stock.quantity - sp.quantity
      stock.update_attributes(:quantity => new_qty)
    end
  end
end
