class Sale < ActiveRecord::Base

  belongs_to :person
  belongs_to :headquarter
  belongs_to :seller

  has_many :sale_products, :dependent => :destroy
  has_many :separates, :dependent => :destroy
  has_many :products, :through => :sale_products

  accepts_nested_attributes_for :sale_products,
                                :allow_destroy => true

  accepts_nested_attributes_for :separates, :reject_if => lambda { |sp| sp[:payment].blank?},
                                :allow_destroy => true

  before_update :get_saved_qty, :verify_status
  before_save :update_total_cost, :update_payments_cost
  after_save :update_stock

  attr_accessor :old_quantities

  validates_numericality_of :total, :discount, :iva, :greater_than_or_equal_to => 0, :message => 'debe ser un numero!'

  def get_saved_qty
    sale=Sale.find self.id
    self.old_quantities = sale.sale_products.collect do |sp|
      sp.quantity
    end
    self.old_quantities=[0] if self.old_quantities.nil? || self.old_quantities.empty?
  end

  def update_stock
    index=0
    self.sale_products.each do |sp|
      stock = Stock.find sp.stock_id
      if stock && stock.quantity
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

  def update_total_cost
    total_cost = 0
    index=0
    self.sale_products.each do |sp|
      stock = Stock.where('product_id = ? and headquarter_id = ?', sp.product_id, self.headquarter_id)[0]
      cost=stock.cost rescue 0
      quantity=sp.quantity rescue 0
      total_cost += cost* quantity rescue 0
      index+=1
    end
    self.total_cost = total_cost
  end

  def verify_status
    payments_sum = self.separates.map(&:payment).inject {|mem,el| mem+el}
    if payments_sum
      if payments_sum >= self.total
        self.separated=0
      else
        self.separated=1
      end
    end
  end

  def update_payments_cost
    self.separates.each do |s|
      s.payment_cost=s.payment*self.total_cost/(self.total+self.discount)
    end
  end

  def balance
    if self.separated?
      payments=self.separates.map(&:payment).inject{|sum,x| sum+x} rescue 0
      self.total-payments rescue self.total
    else
      0
    end
  end

  def status
    s=''
    if self.voided?
      s='Anulada'
    end
    if self.separated?
      s+=' Separada'
    else
      s+=' Vendida'
    end
    s
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

