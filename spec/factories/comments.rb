FactoryBot.define do
  factory :comment do
    body { Faker::Hacker.say_something_smart }
    association(:discussion, factory: :discussion)
    association(:user, factory: :user)
  end
end
