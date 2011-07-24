require 'test_helper'

class HeadquarterTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: headquarters
#
#  id          :integer(4)      not null, primary key
#  name        :string(255)
#  address     :string(255)
#  phone       :string(255)
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

