require 'test_helper'

class StockTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: stocks
#
#  id             :integer(4)      not null, primary key
#  product_id     :integer(4)
#  quantity       :integer(4)
#  price          :integer(4)
#  headquarter_id :integer(4)
#  created_at     :datetime
#  updated_at     :datetime
#  cost           :integer(4)
#

