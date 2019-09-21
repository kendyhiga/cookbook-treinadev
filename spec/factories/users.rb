# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'John Doe' }
    sequence(:email) { |n| "person#{n}@example.com" }
    password { '123456' }
  end
end
