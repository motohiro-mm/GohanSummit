# frozen_string_literal: true

FactoryBot.define do
  factory :meal_plan do
    sequence(:meal_date) { |n| Time.zone.today.days_since(n) }
    family

    trait :skip_validation do
      to_create { |meal_plan| meal_plan.save(validate: false) }
    end
  end
end
