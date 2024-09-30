# frozen_string_literal: true

class MeetingRoom < ApplicationRecord
  belongs_to :family
  belongs_to :meal_plan
  has_many :remarks, dependent: :destroy
end
