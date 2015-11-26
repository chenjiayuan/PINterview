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

require 'faker'

FactoryGirl.define do
  factory :pin do |f|
    position {Faker::Commerce.product_name}
    company {"Airbnb"}
    date  {"1" + ' ' + "September, " + "2015"}
    difficulty {"1 - Easy"}
    type_interview {"Onsite"}
    attire "Offer"
    questions {Faker::Hacker.adjective}
    length  {"30 Min"}
    description {Faker::Hacker.say_something_smart}
    position_type {"Fulltime"}
  end
end
