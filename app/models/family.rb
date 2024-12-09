# frozen_string_literal: true

class Family < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :meal_plans, dependent: :destroy
  has_many :meeting_rooms, dependent: :destroy

  validates :invitation_token, presence: true, uniqueness: true

  def destroy_having_no_user
    return if users.exists?

    Family.find(id).destroy
  end
end
