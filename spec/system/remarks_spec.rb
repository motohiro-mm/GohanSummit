# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Remarks', type: :system do
  let(:user) { create(:user) }
  let(:meal_plan) { create(:meal_plan, :with_breakfast_and_dinner, family: user.family) }
  let(:meeting_room) { create(:meeting_room, family: user.family, meal_plan:) }

  before do
    log_in_as user
  end

  describe '提案' do
    let(:proposal) { create(:remark, remark_type: 0, content: 'カレー', meeting_room:, user:) }

    it '新規作成する', :js do
      visit meeting_room_path(meeting_room)
      expect(page).to have_css 'h2', text: '献立の提案'
      click_on '提案する'

      fill_in 'remark_content', with: 'やきにく'
      find_by_id('submit_button').click

      expect(page).to have_content '投稿しました'
      within "#remark_#{Remark.last.id}_content" do
        expect(page).to have_content 'やきにく'
      end
    end

    it '新規作成時に未入力のままチェックボタンを押すとエラーが出る', :js do
      visit meeting_room_path(meeting_room)
      expect(page).to have_css 'h2', text: '献立の提案'
      click_on '提案する'

      find_by_id('submit_button').click
      expect(page).to have_content '提案を入力してください'
    end

    it '新規作成時に20文字以上入力してチェックボタンを押すとエラーが出る', :js do
      visit meeting_room_path(meeting_room)
      expect(page).to have_css 'h2', text: '献立の提案'
      click_on '提案する'

      fill_in 'remark_content', with: '0' * 21
      find_by_id('submit_button').click
      expect(page).to have_content '提案は20文字以内で入力してください'
    end

    it '編集する', :js do
      proposal
      visit meeting_room_path(meeting_room)
      expect(page).to have_css 'h2', text: '献立の提案'
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
      expect(page).to have_css 'h2', text: '献立の提案'
      click_on 'カレー'

      fill_in 'remark_content', with: ''
      find_by_id('submit_button').click
      expect(page).to have_content '提案を入力してください'
    end

    it '編集時に20文字以上入力してチェックボタンを押すとエラーが出る', :js do
      proposal
      visit meeting_room_path(meeting_room)
      expect(page).to have_css 'h2', text: '献立の提案'
      click_on 'カレー'

      fill_in 'remark_content', with: '0' * 21
      find_by_id('submit_button').click
      expect(page).to have_content '提案は20文字以内で入力してください'
    end

    it '削除する', :js do
      proposal
      visit meeting_room_path(meeting_room)
      expect(page).to have_css 'h2', text: '献立の提案'
      click_on 'カレー'
      find_by_id('trash_button').click

      expect(page).to have_content '削除しました'
      expect(page).to have_no_content 'カレー'
    end
  end

  describe 'コメント' do
    let(:comment) { create(:remark, remark_type: 1, content: '時間がないね', meeting_room:, user:) }

    it '新規作成する', :js do
      visit meeting_room_path(meeting_room)
      expect(page).to have_css 'h2', text: 'コメント'
      click_on 'コメントする'

      fill_in 'remark_content', with: 'たくさん食べたい'
      find_by_id('submit_button').click

      expect(page).to have_content '投稿しました'
      expect(page).to have_content 'コメントする'
      within "#remark_#{Remark.last.id}_content" do
        expect(page).to have_content 'たくさん食べたい'
      end
    end

    it '新規作成時に未入力のままチェックボタンを押すとエラーが出る', :js do
      visit meeting_room_path(meeting_room)
      expect(page).to have_css 'h2', text: 'コメント'
      click_on 'コメントする'

      find_by_id('submit_button').click
      expect(page).to have_content 'コメントを入力してください'
    end

    it '新規作成時に50文字以上入力してチェックボタンを押すとエラーが出る', :js do
      visit meeting_room_path(meeting_room)
      expect(page).to have_css 'h2', text: 'コメント'
      click_on 'コメントする'

      fill_in 'remark_content', with: '0' * 51
      find_by_id('submit_button').click
      expect(page).to have_content 'コメントは50文字以内で入力してください'
    end

    it '編集する', :js do
      comment
      visit meeting_room_path(meeting_room)
      within "#remark_#{comment.id}_created_at" do
        expect(page).to have_content Time.zone.today.strftime('%Y/%m/%d')
      end
      find("#remark_#{comment.id}_content", text: '時間がないね').click

      fill_in 'remark_content', with: '楽したい'
      find_by_id('submit_button').click

      expect(page).to have_content '更新しました'
      expect(page).to have_no_content '時間がないね'
      expect(page).to have_content '楽したい'
    end

    it '編集時に入力を削除してチェックボタンを押すとエラーが出る', :js do
      comment
      visit meeting_room_path(meeting_room)
      within "#remark_#{comment.id}_created_at" do
        expect(page).to have_content Time.zone.today.strftime('%Y/%m/%d')
      end
      find("#remark_#{comment.id}_content", text: '時間がないね').click

      fill_in 'remark_content', with: ''
      find_by_id('submit_button').click
      expect(page).to have_content 'コメントを入力してください'
    end

    it '編集時に50文字以上入力してチェックボタンを押すとエラーが出る', :js do
      comment
      visit meeting_room_path(meeting_room)
      within "#remark_#{comment.id}_created_at" do
        expect(page).to have_content Time.zone.today.strftime('%Y/%m/%d')
      end
      find("#remark_#{comment.id}_content", text: '時間がないね').click

      fill_in 'remark_content', with: '0' * 51
      find_by_id('submit_button').click
      expect(page).to have_content 'コメントは50文字以内で入力してください'
    end

    it '削除する', :js do
      comment
      visit meeting_room_path(meeting_room)
      within "#remark_#{comment.id}_created_at" do
        expect(page).to have_content Time.zone.today.strftime('%Y/%m/%d')
      end
      find("#remark_#{comment.id}_content", text: '時間がないね').click
      find_by_id('trash_button').click

      expect(page).to have_content '削除しました'
      expect(page).to have_no_content '時間がないね'
    end
  end
end
