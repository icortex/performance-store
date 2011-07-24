require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: products
#
#  id                 :integer(4)      not null, primary key
#  brand_id           :integer(4)
#  cloth_type_id      :integer(4)
#  reference          :string(255)
#  model              :string(255)
#  barcode            :string(255)
#  gender             :string(255)
#  size_id            :integer(4)
#  color_id           :integer(4)
#  created_at         :datetime
#  updated_at         :datetime
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer(4)
#  image_updated_at   :datetime
#

