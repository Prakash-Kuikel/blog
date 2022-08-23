# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    body { 'This is a dummy post' }
    association :user
  end
end
