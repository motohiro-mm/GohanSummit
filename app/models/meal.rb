# frozen_string_literal: true

class Meal < ApplicationRecord
  belongs_to :meal_plan

  enum :timing, { breakfast: 0, lunch: 1, dinner: 2 }

  validates :timing, presence: true, uniqueness: { scope: :meal_plan_id }
end
