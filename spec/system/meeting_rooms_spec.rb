# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'MeetingRooms', type: :system do
  let(:user) { create(:user) }
  let(:meal_plan) { create(:meal_plan, :with_3_meals, family: user.family) }

  before do
    log_in_as user
  end

  it '献立表一覧から会議室へ遷移する' do
    visit meal_plans_path(start_date: Time.zone.today)
    within "##{cell_day(Time.zone.today)}" do
      click_on('会議室はこちら')
    end

    expect(page).to have_content I18n.l(Time.zone.today, format: :medium)
    expect(page).to have_content '提案する'
    expect(page).to have_content 'コメントする'
  end

  it '献立表詳細画面から会議室へ遷移する' do
    visit meal_plan_path(meal_plan)
    click_on '会議へ'

    expect(page).to have_content I18n.l(Time.zone.today, format: :medium)
    expect(page).to have_content '提案する'
    expect(page).to have_content 'コメントする'
  end
end
