# frozen_string_literal: true

FactoryBot.define do
  factory :meal do
    name { 'TestMeal' }
    memo { 'TestMemo' }
    meal_plan
  end
end
