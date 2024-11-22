# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MealPlansHelper, type: :helper do
  describe '#button_display' do
    it 'newアクションのとき「登録」を返す' do
      allow(helper).to receive(:action_name).and_return('new')
      expect(helper.button_display).to eq('登録')
    end

    it 'editアクションのとき「更新」を返す' do
      allow(helper).to receive(:action_name).and_return('edit')
      expect(helper.button_display).to eq('更新')
    end
  end
end
