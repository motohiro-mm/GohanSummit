# frozen_string_literal: true

FactoryBot.define do
  factory :family do
    sequence(:invitation_token) { |n| "test123family#{n}" }
  end
end
