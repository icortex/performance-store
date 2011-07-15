class Size < ActiveRecord::Base
  has_many :products
  validates :size, :uniqueness => true, :presence => true
end
