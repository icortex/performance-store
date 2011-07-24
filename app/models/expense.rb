class Expense < ActiveRecord::Base
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

