# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MealsHelper, type: :helper do
  describe '#meal_name_placeholder' do
    it '0なら朝食メニュー例を返す' do
      expect(meal_name_placeholder(0)).to eq 'トースト、納豆ごはん'
    end

    it '1なら昼食メニュー例を返す' do
      expect(meal_name_placeholder(1)).to eq 'パスタ、ラーメン'
    end

    it '2なら夕食メニュー例を返す' do
      expect(meal_name_placeholder(2)).to eq 'やきにく、おすし'
    end
  end

  describe '#meal_memo_placeholder' do
    it '0なら朝食のメモ例を返す' do
      expect(meal_memo_placeholder(0)).to eq 'おすすめを作ってみよう'
    end

    it '1なら昼食のメモ例を返す' do
      expect(meal_memo_placeholder(1)).to eq '時間がないからささっと'
    end

    it '2なら夕食のメモ例を返す' do
      expect(meal_memo_placeholder(2)).to eq '給料日なので外食！'
    end
  end

  describe '#alt_meal_timing' do
    it '0かbreakfastなら朝日のマークの説明を返す' do
      expect(alt_meal_timing(0)).to eq '朝ごはんを表す朝日のマーク'
      expect(alt_meal_timing('breakfast')).to eq '朝ごはんを表す朝日のマーク'
    end

    it '1かlunchなら太陽のマークの説明を返す' do
      expect(alt_meal_timing(1)).to eq '昼ごはんを表す太陽のマーク'
      expect(alt_meal_timing('lunch')).to eq '昼ごはんを表す太陽のマーク'
    end

    it '2かdinnerなら月のマークの説明を返す' do
      expect(alt_meal_timing(2)).to eq '夜ごはんを表す月のマーク'
      expect(alt_meal_timing('dinner')).to eq '夜ごはんを表す月のマーク'
    end
  end
end
