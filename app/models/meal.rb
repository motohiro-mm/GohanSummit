# frozen_string_literal: true

class Meal < ApplicationRecord
  belongs_to :meal_plan

  enum :timing, { breakfast: 0, lunch: 1, dinner: 2 }, validate: true

  validates :timing, presence: true, uniqueness: { scope: :meal_plan_id }
  validates :name, length: { maximum: 20 }
  validates :name, presence: true, if: -> { memo.present? }
  validates :name, presence: true, on: :save_by_proposal
  validates :memo, length: { maximum: 200 }

  scope :sort_by_timing, -> { order(:timing) }
end
