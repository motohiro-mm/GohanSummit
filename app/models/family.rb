# frozen_string_literal: true

class Family < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :meal_plans, dependent: :destroy

  validates :invitation_token, presence: true
end
