# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sessions', type: :system do
  let(:family) { create(:family, invitation_token: 'test_token') }
  let(:user) { create(:user, family: family, name: 'TestUser') }

  it 'ログインする' do
    log_in_as user

    expect(page).to have_content 'ログインしました'
  end

  it 'ログインに失敗する' do
    OmniAuth.configure do |config|
      config.test_mode = true
      config.mock_auth[:google_oauth2] =
        OmniAuth::AuthHash.new({
                                 provider: '',
                                 uid: '',
                                 info: { name: '' }
                               })
    end
    visit root_path
    click_on 'Googleでログイン', match: :first

    expect(page).to have_content 'ログインに失敗しました'
  end

  it 'ログインを途中でキャンセルする' do
    visit auth_failure_path

    expect(page).to have_content 'Googleログインがキャンセルされました'
  end

  it 'ログアウトする', :js do
    log_in_as user
    expect(page).to have_content 'ログインしました'

    find_by_id('menu-close').click
    within('#menu-open') do
      click_on('ログアウト')
    end
    expect(page).to have_content 'ログアウトしました'
  end

  it 'ログインせずにログイン後のページを開こうとするとhomeに戻る' do
    visit meal_plans_path

    expect(page).to have_content 'ログインしてください'
  end

  it 'welcomeページからログインする' do
    user
    OmniAuth.configure do |config|
      config.test_mode = true
      config.mock_auth[:google_oauth2] =
        OmniAuth::AuthHash.new({
                                 provider: 'google_oath2',
                                 uid: 'welcometestuser',
                                 info: { name: 'WelcomeMyFamily' }
                               })
    end
    visit welcome_path(invitation_token: user.family.invitation_token)
    click_on 'Googleでログイン', match: :first

    expect(page).to have_content 'ログインしました'
    visit family_path
    expect(page).to have_content 'TestUser'
    expect(page).to have_content 'WelcomeMyFamily'
  end
end
