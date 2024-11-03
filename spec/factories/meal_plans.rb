# frozen_string_literal: true

FactoryBot.define do
  factory :meal_plan do
    sequence(:meal_date) { |n| Time.zone.today.days_since(n) }
    family

    after(:build) do |meal_plan|
      meal_plan.meals << build(:meal, :breakfast, meal_plan:)
      meal_plan.meals << build(:meal, :lunch, meal_plan:)
      meal_plan.meals << build(:meal, :dinner, meal_plan:)
    end
  end
end
