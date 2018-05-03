FactoryBot.define do
  factory :job do
    sequence(:title) { |n| "job #{n}" }
    job_type :uncategorized
    employer_name 'factory'
    description 'some job description'
  end
end
