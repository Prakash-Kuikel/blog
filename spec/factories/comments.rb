FactoryBot.define do
  factory :comment do
    body { 'This is a dummy comment' }
    association :user
    association :post
  end
end
