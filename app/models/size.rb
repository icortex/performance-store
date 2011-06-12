class Size < ActiveRecord::Base
  belongs_to :product
  validates :size, :uniqueness => true, :presence => true
end
