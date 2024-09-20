# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'test_name' }
    sequence(:uid) { |n| "test_user_#{n}" }
    provider { 'google_oauth2' }
    icon { 0 }
    family
  end
end
