# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :system do
  let(:user) { create(:user, name: 'TestUser') }

  before do
    log_in_as user
  end

  it 'ユーザー名を変更する' do
    visit user_path

    expect(page).to have_css 'h1', text: 'ユーザー設定'
    fill_in 'user_name', with: 'UpdatedUser'
    click_on '更新'

    expect(page).to have_content 'ユーザーを更新しました'
    visit user_path
    expect(page).to have_content 'UpdatedUser'
    expect(page).to have_no_content 'TestUser'
  end

  it 'ユーザー名に何も入力しないで更新をクリックするとエラーが表示される' do
    visit user_path

    expect(page).to have_css 'h1', text: 'ユーザー設定'
    fill_in 'user_name', with: ''
    click_on '更新'

    expect(page).to have_content 'ユーザー名を入力してください'
  end

  it 'ユーザーアイコンを変更する', :js do
    visit user_path
    expect(page).to have_css("img[alt='ユーザーアイコンのチンパンジーのイラスト']")

    expect(page).to have_css 'h1', text: 'ユーザー設定'
    find("img[alt='ユーザーアイコンで選べるパンダのイラスト']").click
    click_on '更新'

    expect(page).to have_content 'ユーザーを更新しました'
    expect(page).to have_css("img[alt='ユーザーアイコンのパンダのイラスト']")
  end

  it 'ユーザーを削除する', :js do
    visit user_path

    expect(page).to have_css 'h1', text: 'ユーザー設定'
    page.accept_confirm '本当に削除して良いですか？' do
      click_on 'ユーザーを削除する'
    end

    expect(page).to have_content 'ユーザーを削除しました'
    expect(page).to have_current_path root_path, ignore_query: true
  end
end
