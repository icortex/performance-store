class ClothType < ActiveRecord::Base
  has_one :product
  validates_presence_of :cloth_type
  validates_uniqueness_of :cloth_type, :case_sensitive => false
end
