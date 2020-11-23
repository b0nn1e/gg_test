FactoryBot.define do
  factory :campaign do
    subject { generate(:subject) }
    message { generate(:message) }
  end

  factory :customer do
    email { generate(:email) }
  end

  sequence :email do |n|
    "customer#{n}@gmail.com"
  end

  sequence :subject do |n|
    "subject #{n}"
  end

  sequence :message do |n|
    "message #{n}"
  end
end
