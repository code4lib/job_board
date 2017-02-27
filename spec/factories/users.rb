FactoryGirl.define do
  factory :user do
    uid 'user'
    sequence(:email) { |n| "user#{n}@example.com" }
    password 'insecure'
    
    
    factory :admin do
      uid 'admin'
    end
  end
end
