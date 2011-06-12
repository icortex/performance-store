class Brand < ActiveRecord::Base
  validates_presence_of :brand
  validates_uniqueness_of :brand, :case_sensitive => false
end
