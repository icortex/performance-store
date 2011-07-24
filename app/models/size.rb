class Size < ActiveRecord::Base
  has_many :products
  validates :size, :uniqueness => true, :presence => true
end

# == Schema Information
#
# Table name: sizes
#
#  id         :integer(4)      not null, primary key
#  size       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

