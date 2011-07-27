require 'test_helper'

class SaleTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end


# == Schema Information
#
# Table name: sales
#
#  id              :integer(4)      not null, primary key
#  person_id       :integer(4)
#  discount        :integer(4)
#  discount_reason :string(255)
#  iva             :integer(4)
#  total           :integer(4)
#  created_at      :datetime
#  updated_at      :datetime
#  headquarter_id  :integer(4)
#  total_cost      :integer(4)
#  separated       :boolean(1)      default(FALSE)
#

