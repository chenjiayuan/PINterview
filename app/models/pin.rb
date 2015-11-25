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
#  like_count     :integer          default(0)
#  length         :string
#  description    :string
#  user_id        :integer
#  position_type  :string
#

class Pin < ActiveRecord::Base
    acts_as_votable

  	belongs_to :user
    has_many :favorite_pins
    has_many :favorited_by, through: :favorite_pins, source: :user

    validates :position, presence: true, length: {maximum: 40}    
    validates :company, presence: true, length: {maximum: 40}
    validates :date, presence: true, length: { maximum: 40}
    validates :difficulty, presence: true, length: {maximum: 30}
    validates :position_type, presence: true, length: {maximum: 30}
    validates :type_interview, presence: true, length: {maximum: 30}
    validates :attire, presence: true, length: {maximum: 30}
    validates :questions, presence: true, length: {maximum: 1000}
    validates :length, presence: true, length: {maximum: 40}
    validates :description, length: {maximum: 1000} 

    UNRANSACKABLE_ATTRIBUTES = ["date", "account_id", "attire", "length", "user_id"]

    self.per_page = 20

    def self.ransackable_attributes auth_object = nil
        (column_names - UNRANSACKABLE_ATTRIBUTES) + _ransackers.keys
    end
end
