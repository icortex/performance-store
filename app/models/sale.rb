class Sale < ActiveRecord::Base

  belongs_to :person
  belongs_to :headquarter
  
  has_many :sale_products
  has_many :products, :through => :sale_products
end
