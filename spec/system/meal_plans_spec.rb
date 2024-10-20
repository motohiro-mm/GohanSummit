# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'MealPlans', type: :system do
  let(:user) { create(:user) }
  let(:meal_plan) { create(:meal_plan, :skip_validation, family: user.family) }
  let!(:meal_breakfast) { create(:meal, :breakfast, meal_plan:) }
  let!(:meal_lunch) { create(:meal, :lunch, meal_plan:) }
  let!(:meal_dinner) { create(:meal, :dinner, meal_plan:) }

  before do
    log_in_as user
  end

  it '献立を登録する' do
    visit new_meal_plan_path(meal_date: Time.zone.today)

    within '#breakfast' do
      fill_in '料理', with: 'シリアル'
    end
    within '#lunch' do
      fill_in '料理', with: 'ハンバーガー'
    end
    within '#dinner' do
      fill_in '料理', with: 'ステーキ'
    end
    click_on '登録'

    expect(page).to have_content I18n.l(Time.zone.today, format: :long)
    expect(page).to have_content 'シリアル'
    expect(page).to have_content 'ハンバーガー'
    expect(page).to have_content 'ステーキ'
  end

  it '献立を詳細表示する' do
    visit meal_plans_path(start_date: meal_plan.meal_date)
    click_on meal_breakfast.name

    expect(page).to have_text I18n.l(meal_plan.meal_date, format: :long)
    expect(page).to have_content meal_breakfast.memo
    expect(page).to have_content meal_lunch.memo
    expect(page).to have_content meal_dinner.memo
  end

  it '献立を編集する' do
    visit meal_plan_path(meal_plan)
    click_on 'edit_pen'

    within '#lunch' do
      fill_in '料理', with: 'EditName'
    end
    click_on '更新'

    expect(page).to have_content 'EditName'
  end
end
