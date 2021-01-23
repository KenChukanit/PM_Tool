  
FactoryBot.define do
  factory :project do
    sequence(:title) { |n| Faker::Movies::StarWars.character + " #{n}"}
    description { Faker::Hacker.say_something_smart }
    due_date {Faker::Date.forward(days: 23)}
    association(:user, factory: :user)
    created_at {Time.zone.now}
  end
end
