FactoryBot.define do
  factory :user do
    uid { 'user' }
    sequence(:email) { |n| "user#{n}@example.com" }
    password { 'insecure' }


    factory :admin do
      uid { 'admin' }

      after(:build) do |user, evaluator|
        user.add_role :admin
      end
    end
  end
end
