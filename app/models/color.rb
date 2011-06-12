class Color < ActiveRecord::Base
  belongs_to :product
  validates_uniqueness_of :color, :scope => :rgb
  validates :rgb, :presence => true, :length => { :within => 1..6}
end
