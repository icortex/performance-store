class Contact < ActiveRecord::Base
  belongs_to :person
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

