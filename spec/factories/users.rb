# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'TestUserName' }
    sequence(:uid) { |n| "TestUser#{n}" }
    provider { 'google_oauth2' }
    icon { 0 }
    family
  end
end
