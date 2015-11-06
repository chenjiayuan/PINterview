require 'faker'

FactoryGirl.define do
  factory :pin do |f|
    f.position {Faker::Commerce.product_name}
    f.company {Faker::Company.name}
    f.date  {"10/20/2015"}
    f.difficulty {"Easy"}
    f.type_interview {Faker::Hacker.adjective}
    f.attire "Yes"
    f.questions {Faker::Hacker.adjective}
    f.length  {"1 Hours"}
    f.description {Faker::Hacker.say_something_smart}
  end
end
