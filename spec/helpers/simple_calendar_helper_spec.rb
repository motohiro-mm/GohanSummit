# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SimpleCalendarHelper, type: :helper do
  describe '#cell_day' do
    it '正しい文字列が返る' do
      expect(cell_day(Date.new(2024, 11, 1))).to eq 'cell20241101'
    end
  end
end
