require 'test_helper'

class FaultyTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: faulties
#
#  id          :integer(4)      not null, primary key
#  product_id  :integer(4)
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

