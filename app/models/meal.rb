# frozen_string_literal: true

class Meal < ApplicationRecord
  belongs_to :meal_plan

  enum :timing, { breakfast: 0, lunch: 1, dinner: 2 }, validate: true

  validates :timing, presence: true, uniqueness: { scope: :meal_plan_id }
  validates :name, length: { maximum: 20 }
  validates :memo, length: { maximum: 200 }

  scope :sort_by_timing, -> { order(:timing) }

  def create_or_update_meal_name(meal_plan)
    same_timing_meal = meal_plan.meals.find_by(timing: self[:timing])
    if same_timing_meal.nil?
      self.meal_plan = meal_plan
      save
    else
      same_timing_meal.name = self[:name]
      same_timing_meal.memo = ''
      same_timing_meal.save
    end
  end
end
