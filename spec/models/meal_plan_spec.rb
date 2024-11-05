# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MealPlan, type: :model do
  let(:user) { create(:user) }
  let(:meal_plan) { create(:meal_plan, :with_breakfast_and_dinner, family: user.family) }

  describe '#update_meal_plan' do
    it 'meal_planのmealsを渡すとmealを更新して不要なmealは削除する' do
      breakfast_params = { id: meal_plan.meals.find_by(timing: 'breakfast').id, name: '朝ごはん', memo: '', timing: 'breakfast' }
      lunch_params = { id: nil, name: '昼ごはん', memo: '', timing: 'lunch' }
      dinner_params = { id: meal_plan.meals.find_by(timing: 'dinner').id, name: '', memo: '', timing: 'dinner' }
      three_meals_params = { meals_attributes: { '0': breakfast_params, '1': lunch_params, '2': dinner_params } }
      meal_plan.update_meal_plan(three_meals_params)
      meal_plan.meals.reload
      expect(meal_plan.meals.map(&:name).sort).to eq %w[昼ごはん 朝ごはん]
      expect(meal_plan.meals.map(&:timing).sort).to eq %w[breakfast lunch]
    end
  end

  describe '#meals_build' do
    it 'meal_planが持っていないtimingのmealを作成する' do
      meal_plan.meals_build
      expect(meal_plan.meals.size).to eq 3
      added_meals = meal_plan.meals.filter { |meal| meal.id.nil? }
      expect(added_meals.map(&:timing)).to eq %w[lunch]
    end
  end
end
