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

class FavoritePin < ActiveRecord::Base
	belongs_to :user
  	belongs_to :pin
end
