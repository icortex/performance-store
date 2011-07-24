require 'test_helper'

class LotProductTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: lot_products
#
#  id         :integer(4)      not null, primary key
#  product_id :integer(4)
#  lot_id     :integer(4)
#  quantity   :integer(4)
#  unit_cost  :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

