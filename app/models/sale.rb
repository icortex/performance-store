class Sale < ActiveRecord::Base

  belongs_to :person
  belongs_to :headquarter
  
  has_many :sale_products, :dependent => :destroy
  has_many :products, :through => :sale_products
  accepts_nested_attributes_for :sale_products, :reject_if => lambda { |sp| sp[:product_id].blank? }, :allow_destroy => true

end
