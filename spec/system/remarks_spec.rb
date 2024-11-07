# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Remarks', type: :system do
  let(:user) { create(:user) }
  let(:meal_plan) { create(:meal_plan, :with_breakfast_and_dinner, family: user.family) }
  let(:meeting_room) { create(:meeting_room, family: user.family, meal_plan:) }
  let(:proposal) { create(:remark, remark_type: 0, content: 'カレー', meeting_room:, user:) }

  before do
    log_in_as user
  end

  describe '提案' do
    it '新規作成する', :js do
      # visit meeting_room_path(meeting_room)
      # click_on '提案する'
      #
      # fill_in 'remark_content', with: 'やきにく'
      # find_by_id('submit_button').click
      #
      # expect(page).to have_content '投稿しました'
      # within '#proposals' do
      #   expect(page).to have_content 'やきにく'
      #   expect(page).to have_content '登録'
      # end

      # ファイル単位では問題なくテストが通りますが全体で実行するとテストが落ちやすいので、意図的にexpectを増やしています
      visit meeting_room_path(meeting_room)
      expect(page).to have_content I18n.l(meal_plan.meal_date, format: :long)
      expect(page).to have_content "この日の\n献立"
      expect(page).to have_link '提案する'
      expect(page).to have_link 'コメントする'
      expect(page).to have_css 'h2', text: '候補'
      expect(page).to have_content "食べたいものを提案しましょう！\n提案した料理はそのまま献立表に\n登録ができます"
      click_on '提案する'

      expect(page).to have_css 'textarea'
      expect(page).to have_button(id: 'submit_button')
      expect(page).to have_link nil, href: meeting_room_path(meeting_room)
      fill_in 'remark_content', with: 'やきにく'
      find_by_id('submit_button').click

      expect(page).to have_content '投稿しました'
      within '#proposals' do
        expect(page).to have_content 'やきにく'
        expect(page).to have_content '登録'
      end

    end

    it '新規作成時に未入力のままチェックボタンを押すとエラーが出る', :js do
      visit meeting_room_path(meeting_room)
      click_on '提案する'

      find_by_id('submit_button').click
      expect(page).to have_content '内容を入力してください'
    end

    it '編集する', :js do
      proposal
      visit meeting_room_path(meeting_room)
      click_on 'カレー'

      fill_in 'remark_content', with: 'シチュー'
      find_by_id('submit_button').click

      expect(page).to have_content '更新しました'
      expect(page).to have_no_content 'カレー'
      expect(page).to have_content 'シチュー'
    end

    it '編集時に入力を削除してチェックボタンを押すとエラーが出る', :js do
      proposal
      visit meeting_room_path(meeting_room)
      click_on 'カレー'

      fill_in 'remark_content', with: ''
      find_by_id('submit_button').click
      expect(page).to have_content '内容を入力してください'
    end

    it '削除する', :js do
      proposal
      visit meeting_room_path(meeting_room)
      click_on 'カレー'
      find_by_id('trash_button').click

      expect(page).to have_content '削除しました'
      expect(page).to have_no_content 'カレー'
    end
  end
end
