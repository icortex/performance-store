class Sale < ActiveRecord::Base
  belongs_to :person
  has_many :sale_products
  belongs_to :headquarter
end
