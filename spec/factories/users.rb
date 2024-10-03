FactoryBot.define do
  factory :user do
    full_name { "John Doe" }
    user_name { "johndoe123" }
    email { "john.doe@example.com" }
    phone_number { "1234567890" }
    date_of_birth { "1990-01-01" }
    experience_years { 5 }
    address { "123 Main St" }
    district { "Downtown" }
    pin_code { "123456" }
    password { "password123" }
    password_confirmation { "password123" }

    after(:build) do |user|
      user.professions << FactoryBot.build(:profession)
    end
  end

  factory :profession do
    sequence(:name) { |n| "Profession_#{n}" }
  end
end
