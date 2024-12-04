# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Meal, type: :model do
  let(:user) { create(:user) }
  let(:meal_plan) { create(:meal_plan, :with_breakfast_and_dinner, family: user.family) }

  describe '#sort_by_timing' do
    it '食事タイミングでソートされる' do
      expect(meal_plan.meals.sort_by_timing.map(&:name)).to eq %w[BreakfastName DinnerName]
    end
  end
end
