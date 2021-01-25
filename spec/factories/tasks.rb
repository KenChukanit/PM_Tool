FactoryBot.define do
  factory :task do
    sequence(:title) { |n| Faker::Movies::StarWars.character + " #{n}"}
    body { Faker::Hacker.say_something_smart }
    due_date {Faker::Date.forward(days: 19)}
    association(:project, factory: :project)
    status {0}

  end
end
