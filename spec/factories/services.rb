FactoryBot.define do
  factory :service do
    sequence(:name) { |n| Service::SERVICES['Application (Spraying & Spreading)'][n % 4] }
  end
end
