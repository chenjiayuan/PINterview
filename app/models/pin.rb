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

class Pin < ActiveRecord::Base
	#attr_accessible :title, :company, :date, :difficulty, :type, :attire, :questions, :like_count,
	#			    :length, :description
  def user_params
      params.require(:pin).permit(:title, :company, :date, :difficulty, :type, :attire, :questions, :like_count, :length, :description)
  end
end
