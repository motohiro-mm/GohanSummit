# frozen_string_literal: true

class MealPlan < ApplicationRecord
  belongs_to :family
  has_one :meeting_room, dependent: :destroy
  has_many :meals, dependent: :destroy

  validates :meal_date, presence: true, uniqueness: { scope: :family_id }

  accepts_nested_attributes_for :meals, allow_destroy: true, reject_if: :reject_timing

  def reject_timing(attributes)
    attributes.except(:timing).values.all?(&:blank?)
  end

  def update_meal_plan(attributes)
    if attributes[:meals_attributes].keys.size == 1
      create_or_update_meals_by_proposal(attributes)
    else
      update(attributes)
      destroy_unnecessary_meals(attributes)
    end
  end

  def create_or_update_meals_by_proposal(attributes)
    new_meal_params = attributes[:meals_attributes]['0']
    same_timing_meal = meals.find_by(timing: new_meal_params[:timing])
    if same_timing_meal.nil?
      meals.create(new_meal_params)
    else
      same_timing_meal.name = new_meal_params[:name]
      same_timing_meal.save
    end
  end

  def destroy_unnecessary_meals(attributes)
    attributes[:meals_attributes].each_value do |update_meal|
      meals.find(update_meal[:id]).destroy if update_meal[:id].present? && update_meal.except(:id, :timing).values.all?(&:blank?)
    end
  end

  def meals_build
    required_timings = Meal.timings.keys - meals.pluck(:timing)
    required_timings.each do |required_timing|
      meals.build(timing: required_timing)
    end
  end

  def meals_sort_by_timing
    meals.sort_by { |meal| Meal.timings[meal.timing] }
  end

  def start_time
    meal_date
  end
end
