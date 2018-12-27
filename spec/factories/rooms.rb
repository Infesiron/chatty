FactoryBot.define do
  factory :room do
    title { Faker::Lorem.word }
    hidden { false }
    created_at { Time.zone.now }
  end

  factory :hidden_room, class: "Room" do
    title { Faker::Lorem.word }
    hidden { true }
    created_at { Time.zone.now }
  end
end
