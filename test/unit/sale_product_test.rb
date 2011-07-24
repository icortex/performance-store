require 'test_helper'

class SaleProductTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: sale_products
#
#  id         :integer(4)      not null, primary key
#  sale_id    :integer(4)
#  product_id :integer(4)
#  quantity   :integer(4)
#  price      :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

