FactoryBot.define do
  factory :post do
    body { 'This is a dummy post' }
    association :user
  end
end
