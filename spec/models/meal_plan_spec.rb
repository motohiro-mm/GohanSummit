# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MealPlan, type: :model do
  let(:user) { create(:user) }
  let(:meal_plan) { create(:meal_plan, :with_breakfast_and_dinner, family: user.family) }

  describe '#update_meal_plan' do
    let(:breakfast_params) { { id: meal_plan.meals.find_by(timing: 'breakfast').id, name: '朝ごはん', memo: '', timing: 'breakfast' } }
    let(:lunch_params) { { id: nil, name: '昼ごはん', memo: '', timing: 'lunch' } }
    let(:dinner_params) { { id: meal_plan.meals.find_by(timing: 'dinner').id, name: '', memo: '', timing: 'dinner' } }

    it 'meal_planのmealが1つ渡され、同じタイミングのmealがないとき、mealが新規保存される' do
      lunch_meal_params = ActionController::Parameters.new(meals_attributes: ActionController::Parameters.new('0': lunch_params)).permit(
        meals_attributes: %i[id name memo timing]
      )
      meal_plan.update_meal_plan(lunch_meal_params)
      meal_plan.meals.reload
      expect(meal_plan.meals.map(&:name)).to eq %w[BreakfastName DinnerName 昼ごはん]
      expect(meal_plan.meals.map(&:timing)).to eq %w[breakfast dinner lunch]
    end

    it 'meal_planのmealが1つ渡され、同じタイミングのmealがすでにあるとき、mealが上書き保存される' do
      breakfast_meal_params = ActionController::Parameters.new(meals_attributes: ActionController::Parameters.new('0': breakfast_params)).permit(
        meals_attributes: %i[id name memo timing]
      )
      meal_plan.update_meal_plan(breakfast_meal_params)
      meal_plan.meals.reload
      expect(meal_plan.meals.map(&:name)).to eq %w[DinnerName 朝ごはん]
      expect(meal_plan.meals.map(&:timing)).to eq %w[dinner breakfast]
    end

    it 'meal_planのmealが3つ渡されたときにmealsは更新され不要なmealは削除される' do
      three_meals_params = ActionController::Parameters.new(meals_attributes: ActionController::Parameters.new('0': breakfast_params, '1': lunch_params, '2': dinner_params)).permit(
        meals_attributes: %i[id name memo timing]
      )
      meal_plan.update_meal_plan(three_meals_params)
      meal_plan.meals.reload
      expect(meal_plan.meals.map(&:name)).to eq %w[朝ごはん 昼ごはん]
      expect(meal_plan.meals.map(&:timing)).to eq %w[breakfast lunch]
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
