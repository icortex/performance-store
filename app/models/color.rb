class Color < ActiveRecord::Base
  belongs_to :product
  validates_uniqueness_of :color, :scope => :rgb
  validates :rgb, :presence => true, :length => {:within => 1..6}
end

# == Schema Information
#
# Table name: colors
#
#  id         :integer(4)      not null, primary key
#  color      :string(255)
#  created_at :datetime
#  updated_at :datetime
#  rgb        :string(255)
#

