FactoryBot.define do
  factory :discussion do
    sequence(:title) { |n| Faker::Movies::StarWars.character + " #{n}"}
    description { Faker::Hacker.say_something_smart }
    association(:project, factory: :project)
    association(:user, factory: :user)
  end
end
