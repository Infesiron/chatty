FactoryBot.define do
  factory :user do
    email { "user@mail.com" }
    password { "password" }
    password_confirmation { "password" }
    created_at { Time.zone.now }
  end

  factory :admin, class: "User" do
    email { "admin@mail.com" }
    password { "password" }
    password_confirmation { "password" }
    created_at { Time.zone.now }
    admin { true }
  end
end
