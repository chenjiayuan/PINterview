# == Schema Information
#
# Table name: pins
#
#  id          :integer          not null, primary key
#  title       :string
#  company     :string
#  date        :string
#  difficulty  :integer
#  type        :string
#  attire      :string
#  questions   :string
#  like_count  :integer
#  length      :string
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class PinTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
