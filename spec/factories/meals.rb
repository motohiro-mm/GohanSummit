# frozen_string_literal: true

FactoryBot.define do
  factory :meal do
    sequence(:name) { |n| "TestMeal#{n}" }
    sequence(:memo) { |n| "TestMemo#{n}" }
    meal_plan
  end
end
