FactoryBot.define do
  factory :task do
    headline { 'First Task'}
    latitude { 51.508045 }
    longitude { -0.128217 }
    category { 'Agri Contracting'}
    subcategory { 'Application (Spraying & Spreading)'}
    description { 'Test description'}
    association :user

    after(:build) do |task|
      task.services << build(:service, task: task)
    end
  end
end
