# frozen_string_literal: true

class MealPlan < ApplicationRecord
  belongs_to :family
  has_many :meals, dependent: :destroy

  validates :meal_date, presence: true, uniqueness: { scope: :family_id }

  accepts_nested_attributes_for :meals, allow_destroy: true

  def start_time
    meal_date
  end
end
