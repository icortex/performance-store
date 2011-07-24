class Brand < ActiveRecord::Base
  validates_presence_of :brand
  validates_uniqueness_of :brand, :case_sensitive => false
end

# == Schema Information
#
# Table name: brands
#
#  id         :integer(4)      not null, primary key
#  brand      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

