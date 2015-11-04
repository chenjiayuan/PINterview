# == Schema Information
#
# Table name: pins
#
#  id             :integer          not null, primary key
#  position       :string
#  company        :string
#  date           :string
#  difficulty     :string
#  type_interview :string
#  attire         :string
#  questions      :string
#  like_count     :integer
#  length         :string
#  description    :string
#  created_at     :datetime
#  updated_at     :datetime
#

require 'test_helper'

class PinTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
