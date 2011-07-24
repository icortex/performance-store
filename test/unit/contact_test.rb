require 'test_helper'

class ContactTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: contacts
#
#  id         :integer(4)      not null, primary key
#  key        :string(255)
#  value      :string(255)
#  person_id  :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

