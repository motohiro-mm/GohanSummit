# frozen_string_literal: true

FactoryBot.define do
  factory :meal_plan do
    sequence(:meal_date) { |n| Time.zone.today.days_since(n) }
    family

    trait :with_3_meals do
      after(:build) do |meal_plan|
        meal_plan.meals << build(:meal, :breakfast, meal_plan:, name: 'BreakfastName')
        meal_plan.meals << build(:meal, :lunch, meal_plan:, name: 'LunchName')
        meal_plan.meals << build(:meal, :dinner, meal_plan:, name: 'DinnerName')
      end
    end

    trait :with_breakfast_and_dinner do
      after(:build) do |meal_plan|
        meal_plan.meals << build(:meal, :breakfast, meal_plan:, name: 'BreakfastName')
        meal_plan.meals << build(:meal, :dinner, meal_plan:, name: 'DinnerName')
      end
    end
  end
end
