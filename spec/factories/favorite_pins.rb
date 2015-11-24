# == Schema Information
#
# Table name: favorite_pins
#
#  id         :integer          not null, primary key
#  pin_id     :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :favorite_pin do
    pin_id 1
user_id 1
  end

end
