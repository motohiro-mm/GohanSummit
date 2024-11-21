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

  describe '#create_or_udpate_meal_name' do
    it 'meal_planに同じタイミングのmealがないとき、mealが新規保存される' do
      meal = build(:meal, name: '昼ごはん', timing: 'lunch')
      meal.create_or_update_meal_name(meal_plan)
      meal_plan.meals.reload
      expect(meal_plan.meals.map(&:name).sort).to eq %w[BreakfastName DinnerName 昼ごはん]
      expect(meal_plan.meals.map(&:timing).sort).to eq %w[breakfast dinner lunch]
    end

    it 'meal_planに同じタイミングのmealがすでにあるとき、mealが上書き保存される' do
      meal = build(:meal, name: '朝ごはん', timing: 'breakfast')
      meal.create_or_update_meal_name(meal_plan)
      meal_plan.meals.reload
      expect(meal_plan.meals.map(&:name).sort).to eq %w[DinnerName 朝ごはん]
      expect(meal_plan.meals.map(&:timing).sort).to eq %w[breakfast dinner]
    end
  end
end
