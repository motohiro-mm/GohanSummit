# frozen_string_literal: true

class MealPlan < ApplicationRecord
  belongs_to :family
  has_one :meeting_room, dependent: :destroy
  has_many :meals, dependent: :destroy

  validates :meal_date, presence: true, uniqueness: { scope: :family_id }

  accepts_nested_attributes_for :meals, allow_destroy: true

  def update_meal_plan(attributes)
    if attributes[:meals_attributes].keys.size == 1
      meals_create if meals.blank?
      new_meal_params = attributes[:meals_attributes]['0']
      update_meal = meals.find_by(timing: new_meal_params[:timing])
      update_meal.name = new_meal_params[:name]
      update_meal.save
    else
      update(attributes)
    end
  end

  def meals_build
    3.times { meals.build }
  end

  def meals_create
    3.times { |n| meals.create(timing: Meal.timings.keys[n]) }
  end

  def start_time
    meal_date
  end
end
