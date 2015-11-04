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

class Pin < ActiveRecord::Base
  belongs_to :user

    validates :position, presence: true, length: {maximum: 40}    
    validates :company, presence: true, length: {maximum: 40}
    validates :date, presence: true, length: { maximum: 40}
    validates :type_interview, presence: true, length: {maximum: 30}
    validates :attire, presence: true, length: {maximum: 30}
    validates :questions, presence: true, length: {maximum: 240}
    validates :length, presence: true, length: {maximum: 30}
    validates :description, length: {maximum: 320}
end
