FactoryBot.define do
  factory :message do
    body { Faker::Lorem.sentence }
    association :user, factory: :user
    association :room, factory: :room
    created_at { Time.zone.now }
  end
end
