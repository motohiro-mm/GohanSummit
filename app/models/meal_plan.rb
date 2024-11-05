# frozen_string_literal: true

class MealPlan < ApplicationRecord
  belongs_to :family
  has_one :meeting_room, dependent: :destroy
  has_many :meals, dependent: :destroy

  validates :meal_date, presence: true, uniqueness: { scope: :family_id }
  validate :at_least_a_meal?

  accepts_nested_attributes_for :meals, allow_destroy: true, reject_if: :reject_timing

  def update_meal_plan(attributes)
    assign_attributes(attributes)
    return unless save

    destroy_unnecessary_meals(attributes)
  end

  def meals_build
    required_timings = Meal.timings.keys - meals.pluck(:timing)
    required_timings.each do |required_timing|
      meals.build(timing: required_timing)
    end
  end

  def start_time
    meal_date
  end

  private

  def at_least_a_meal?
    meal_names = meals.map { |meal| meal[:name] }
    return if meal_names.any?(&:present?)

    errors.add(:base, '料理名を最低1つ入力してください')
  end

  def destroy_unnecessary_meals(attributes)
    attributes[:meals_attributes].each_value do |update_meal|
      meals.find(update_meal[:id]).destroy if update_meal[:id].present? && update_meal.except(:id, :timing).values.all?(&:blank?)
    end
  end

  def reject_timing(attributes)
    attributes.except(:timing).values.all?(&:blank?)
  end
end
