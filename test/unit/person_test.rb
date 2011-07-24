require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: people
#
#  id          :integer(4)      not null, primary key
#  name        :string(255)
#  birthday    :date
#  document_id :string(255)
#  gender      :string(255)
#  phone       :string(255)
#  mobile      :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  email       :string(255)
#

