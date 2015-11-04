# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string
#  email           :string
#  password_digest :string
#  major           :string
#  grad_class      :string
#

require 'faker'

FactoryGirl.define do
  factory :user do |f|
    f.username {Faker::Internet.user_name}
    f.password {Faker::Internet.password}
    f.email  {Faker::Internet.email}
    f.grad_class "2016"
    f.major {Faker::Hacker.abbreviation}
  end
end
