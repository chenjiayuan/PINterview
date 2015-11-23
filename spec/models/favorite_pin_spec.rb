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

require 'rails_helper'

RSpec.describe FavoritePin, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
