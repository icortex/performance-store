class Sale < ActiveRecord::Base

  belongs_to :person
  belongs_to :headquarter

  has_many :sale_products, :dependent => :destroy
  has_many :products, :through => :sale_products
  accepts_nested_attributes_for :sale_products, :reject_if => lambda { |sp| sp[:reference].blank? },
                                :allow_destroy => true

  before_update :get_saved_qty
  after_save :update_stock
  before_save :update_total_cost

  attr_accessor :old_quantities

  validates_numericality_of :total, :discount, :iva, :greater_than_or_equal_to => 0, :message => 'debe ser un numero!'

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

  def update_total_cost
    total_cost = 0
    index=0
    self.sale_products.each do |sp|
      stock = Stock.where('product_id = ? and headquarter_id = ?', sp.product_id, self.headquarter_id)[0]
      total_cost += stock.cost * sp.quantity
      index+=1
    end
    self.total_cost = total_cost
  end
end

# == Schema Information
#
# Table name: sales
#
#  id              :integer(4)      not null, primary key
#  person_id       :integer(4)
#  discount        :integer(4)
#  discount_reason :string(255)
#  iva             :integer(4)
#  total           :integer(4)
#  created_at      :datetime
#  updated_at      :datetime
#  headquarter_id  :integer(4)
#  total_cost      :integer(4)
#

