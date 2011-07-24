class ClothType < ActiveRecord::Base
  has_one :product
  validates_presence_of :cloth_type
  validates_uniqueness_of :cloth_type, :case_sensitive => false
end

# == Schema Information
#
# Table name: cloth_types
#
#  id         :integer(4)      not null, primary key
#  cloth_type :string(255)
#  created_at :datetime
#  updated_at :datetime
#

