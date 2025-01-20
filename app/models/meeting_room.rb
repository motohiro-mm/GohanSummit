# frozen_string_literal: true

class MeetingRoom < ApplicationRecord
  belongs_to :family
  belongs_to :meal_plan
  has_many :remarks, dependent: :destroy

  def meal_plan_date
    I18n.l(meal_plan.meal_date, format: :medium)
  end
end
