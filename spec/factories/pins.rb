require 'faker'

FactoryGirl.define do
  factory :pin do |f|
    f.title {Faker::Internet.title}
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