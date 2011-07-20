class Sale < ActiveRecord::Base

  belongs_to :person
  belongs_to :headquarter

  has_many :sale_products, :dependent => :destroy
  has_many :products, :through => :sale_products
  accepts_nested_attributes_for :sale_products, :reject_if => lambda { |sp| sp[:reference].blank? },
                                :allow_destroy => true


  after_save :update_stock
  before_update :get_saved_qty

  attr_accessor :old_quantities

  def get_saved_qty
    sale=Sale.find self.id
    self.old_quantities = sale.sale_products.collect do |sp|
      sp.quantity
    end
  end

  def update_stock
    index=0
    self.sale_products.each do |sp|
      stock = Stock.where('product_id = ? and headquarter_id = ?', sp.product_id, self.headquarter_id)[0]
      if self.old_quantities.nil?
        new_qty = stock.quantity - sp.quantity
      else
        new_qty = stock.quantity - sp.quantity + self.old_quantities[index]
      end
      stock.update_attributes(:quantity => new_qty)
      index+=1
    end
  end
end
