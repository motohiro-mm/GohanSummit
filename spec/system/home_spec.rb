# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Home', type: :system do
  let(:user) { create(:user) }

  describe '未ログイン' do
    it '利用規約を開く' do
      visit root_path
      click_on '利用規約', match: :first

      expect(page).to have_css 'h1', text: '利用規約'
    end

    it 'プライバシーポリシーを開く' do
      visit root_path
      click_on 'プライバシーポリシー', match: :first

      expect(page).to have_css 'h1', text: 'プライバシーポリシー'
    end
  end

  describe 'ログイン状態' do
    before do
      log_in_as user
    end

    it '利用規約を開く', :js do
      find_by_id('menu-close').click
      within('#menu-open') do
        click_on('利用規約')
      end

      expect(page).to have_css 'h1', text: '利用規約'
    end

    it 'プライバシーポリシーを開く', :js do
      find_by_id('menu-close').click
      within('#menu-open') do
        click_on('プライバシーポリシー')
      end

      expect(page).to have_css 'h1', text: 'プライバシーポリシー'
    end

    it '使い方ページを開く', :js do
      find_by_id('menu-close').click
      within('#menu-open') do
        click_on('使い方')
      end

      expect(page).to have_css 'h1', text: '使い方'
    end
  end
end
