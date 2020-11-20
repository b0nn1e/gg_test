FactoryBot.define do
  factory :campaign do
    subject { 'subject' }
    message { 'message' }
  end

  factory :recipient do
    email { generate(:email) }
  end

  sequence :email do |n|
    "recipient#{n}@gmail.com"
  end
end
