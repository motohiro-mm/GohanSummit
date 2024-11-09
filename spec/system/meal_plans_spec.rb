# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'MealPlans', type: :system do
  let(:user) { create(:user) }
  let(:meal_plan) { create(:meal_plan, :with_3_meals, family: user.family) }

  before do
    log_in_as user
  end

  it '献立を一覧表示する' do
    visit meal_plans_path(start_date: meal_plan.meal_date)
    expect(page).to have_content '今週'
    within "##{cell_day(meal_plan.meal_date)}" do
      expect(page).to have_content 'BreakfastName'
    end
  end

  it '献立を登録する' do
    visit meal_plans_path(start_date: Time.zone.today)
    within "##{cell_day(Time.zone.today)}" do
      find_by_id('plus_icon').click
    end

    expect(page).to have_content I18n.l(Time.zone.today, format: :medium)
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

    expect(page).to have_content '献立を作成しました'
    expect(page).to have_content 'シリアル'
    expect(page).to have_content 'ハンバーガー'
    expect(page).to have_content 'ステーキ'
  end

  it '献立をなにも入力せず登録しようとしてバリデーションエラーが出る' do
    visit meal_plans_path(start_date: Time.zone.today)
    within "##{cell_day(Time.zone.today)}" do
      find_by_id('plus_icon').click
    end

    expect(page).to have_content I18n.l(Time.zone.today, format: :medium)
    click_on '登録'

    expect(page).to have_content '料理名を最低1つ入力してください'
    expect(page).to have_button('登録', visible: :all)
  end

  it '献立を詳細表示する' do
    visit meal_plans_path(start_date: meal_plan.meal_date)
    click_on 'BreakfastName'

    expect(page).to have_text I18n.l(meal_plan.meal_date, format: :medium)
    expect(page).to have_content 'TestMemo'
  end

  it '献立を編集する' do
    visit meal_plan_path(meal_plan)
    click_on 'edit_pen'

    within '#lunch' do
      fill_in '料理', with: 'EditName'
    end
    click_on '更新'

    expect(page).to have_content '更新しました'
    expect(page).to have_content 'EditName'
  end

  it '編集中の献立の入力を全て削除し更新しようとしてバリデーションエラーが出る' do
    visit meal_plan_path(meal_plan)
    click_on 'edit_pen'

    within '#breakfast' do
      fill_in '料理', with: ''
    end
    within '#lunch' do
      fill_in '料理', with: ''
    end
    within '#dinner' do
      fill_in '料理', with: ''
    end
    click_on '更新'

    expect(page).to have_content '料理名を最低1つ入力してください'
    expect(page).to have_button('更新', visible: :all)
  end

  it '献立を削除する', :js do
    visit meal_plan_path(meal_plan)
    page.accept_confirm '本当に削除して良いですか？' do
      click_on 'この献立を削除する'
    end
    expect(page).to have_content '削除しました'
  end

  it '献立をカレンダー表示する' do
    meal_plan
    visit meal_plans_calendar_path
    expect(page).to have_content '今月'
    within "##{cell_day(meal_plan.meal_date)}" do
      expect(page).to have_content 'BreakfastName'
    end
  end
end
