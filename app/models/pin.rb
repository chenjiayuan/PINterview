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
#  user_id        :integer
#

class Pin < ActiveRecord::Base
    acts_as_votable
  	belongs_to :user
  	before_save :set_default_like

    validates :position, presence: true, length: {maximum: 40}    
    validates :company, presence: true, length: {maximum: 40}
    validates :date, presence: true, length: { maximum: 40}
    validates :difficulty, length: {maximum: 30}
    validates :type_interview, presence: true, length: {maximum: 30}
    validates :attire, presence: true, length: {maximum: 30}
    validates :questions, presence: true, length: {maximum: 240}
    validates :length, presence: true, length: {maximum: 30}
    validates :description, length: {maximum: 320} 

    def set_default_like
    	self.like_count = 0
  	end

    UNRANSACKABLE_ATTRIBUTES = ["id", "date", "account_id", "attire", "like_count", "length", "user_id"]

    def self.ransackable_attributes auth_object = nil
        (column_names - UNRANSACKABLE_ATTRIBUTES) + _ransackers.keys
    end
end
