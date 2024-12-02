# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Meals', type: :system do
  let(:user) { create(:user) }
  let(:meal_plan) { create(:meal_plan, :with_3_meals, family: user.family) }
  let(:meeting_room) { create(:meeting_room, family: user.family, meal_plan: meal_plan) }
  let(:proposal) { create(:remark, user:, meeting_room: meeting_room, remark_type: 0, content: 'カレー') }

  before do
    log_in_as user
  end

  it '提案から献立を登録する' do
    visit new_meal_plan_meal_path(meal_plan, remark: proposal)

    expect(page).to have_content '以下の提案を献立に登録します。'
    within '#timing_checkbox' do
      choose '夜ごはん'
    end
    click_on '登録'

    expect(page).to have_content '登録しました'
    expect(page).to have_content 'BreakfastName'
    expect(page).to have_content 'LunchName'
    expect(page).to have_content 'カレー'
  end

  it 'タイミングがない提案がきたらエラーを返す', :js do
    visit new_meal_plan_meal_path(meal_plan, remark: proposal)

    expect(page).to have_content '以下の提案を献立に登録します。'
    page.execute_script("document.querySelector('input[value=\"lunch\"]').checked = false")
    click_on '登録'

    expect(page).to have_content '食事タイミングを入力してください'
  end

  it '料理名がない提案がきたらエラーを返す', :js do
    visit new_meal_plan_meal_path(meal_plan, remark: proposal)

    expect(page).to have_content '以下の提案を献立に登録します。'
    page.execute_script("document.querySelector('input[name=\"meal[name]\"]').value = ''")
    click_on '登録'

    expect(page).to have_content '料理名を入力してください'
  end
end
