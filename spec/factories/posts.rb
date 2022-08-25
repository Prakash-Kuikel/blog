# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    body { Faker::Lorem.sentence }
    association :user
  end
end
