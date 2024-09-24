# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'MealPlans', type: :system do
  let(:user) { create(:user) }

  before do
    log_in_as user
  end

  it '献立を登録する' do
    visit new_meal_plan_path(meal_date: Date.tomorrow)

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
    expect(page).to have_content Date.tomorrow
    expect(page).to have_content 'シリアル'
    expect(page).to have_content 'ハンバーガー'
    expect(page).to have_content 'ステーキ'
  end
end
