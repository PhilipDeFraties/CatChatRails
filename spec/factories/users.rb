FactoryBot.define do
  factory :user do
    username { Faker::Internet.unique.username(specifier: 4..20) }
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password(min_length: 6) }
    role { "admin" }

    trait :without_email do
      email { nil }
    end

    trait :without_username do
      username { nil }
    end

    trait :with_invalid_email do
      email { "invalid_email" }
    end

    trait :with_short_username do
      username { "abc" }
    end

    trait :with_short_password do
      password { "abc12" }
    end
  end
end