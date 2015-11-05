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

require 'faker'

FactoryGirl.define do
  factory :pin do |f|
    f.title {Faker::Commerce.product_name}
    f.company {Faker::Company.name}
    f.date  {Faker::Number.number(10)}
    f.difficulty {Faker::Number.number(1)}
    f.type {Faker::Hacker.adjective}
    f.attire "Yes"
    f.questions {Faker::Hacker.adjective}
    f.length  {Faker::Internet.email}
    f.description {Faker::Hacker.say_something_smart}
  end
end
