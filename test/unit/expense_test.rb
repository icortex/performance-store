require 'test_helper'

class ExpenseTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: expenses
#
#  id          :integer(4)      not null, primary key
#  name        :string(255)
#  description :string(255)
#  cost        :integer(4)
#  created_at  :datetime
#  updated_at  :datetime
#

