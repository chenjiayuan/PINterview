# == Schema Information
#
# Table name: users
#
#  id                  :integer          not null, primary key
#  username            :string
#  email               :string
#  password_digest     :string
#  major               :string
#  grad_class          :string
#  avatar_file_name    :string
#  avatar_content_type :string
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#

require 'faker'

FactoryGirl.define do
  factory :user do |f|
    username {Faker::Internet.user_name}
    password "123456"
    email  {Faker::Internet.email}
    grad_class "2016"
    major "EECS"
  end
end
