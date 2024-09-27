# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'MealPlans', type: :system do
  let(:user) { create(:user) }
  let(:meal_plan) { create(:meal_plan, family: user.family) }
  let!(:meal_breakfast) { create(:meal, :breakfast, meal_plan:) }
  let!(:meal_lunch) { create(:meal, :lunch, meal_plan:) }
  let!(:meal_dinner) { create(:meal, :dinner, meal_plan:) }

  before do
    log_in_as user
  end

  it '献立を登録する' do
    visit new_meal_plan_path(meal_date: Time.zone.today)

    within '.breakfast' do
      fill_in 'Name', with: 'シリアル'
    end
    within '.lunch' do
      fill_in 'Name', with: 'ハンバーガー'
    end
    within '.dinner' do
      fill_in 'Name', with: 'ステーキ'
    end
    click_on 'Create Meal plan'

    expect(page).to have_css '#notice', text: 'MealPlan was successfully created.'
    expect(page).to have_content Time.zone.today
    expect(page).to have_content 'シリアル'
    expect(page).to have_content 'ハンバーガー'
    expect(page).to have_content 'ステーキ'
  end

  it '献立を詳細表示する' do
    visit meal_plans_path(start_date: meal_plan.meal_date)
    within ".#{css_class_day(meal_plan.meal_date)}" do
      click_on '詳細 >'
    end

    expect(page).to have_css 'h2', text: meal_plan.meal_date
    expect(page).to have_content meal_breakfast.name
    expect(page).to have_content meal_lunch.name
    expect(page).to have_content meal_dinner.name
  end

  it '献立を編集する' do
    visit meal_plan_path(meal_plan)
    click_on 'Edit this meal plan'

    expect(page).to have_css 'h1', text: 'Editing meal_plan'
    within '.lunch' do
      fill_in 'Name', with: 'EditName'
    end
    click_on 'Update Meal plan'

    expect(page).to have_css '#notice', text: 'MealPlan was successfully updated.'
    expect(page).to have_content 'EditName'
  end
end