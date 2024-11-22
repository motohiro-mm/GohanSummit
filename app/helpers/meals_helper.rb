# frozen_string_literal: true

module MealsHelper
  def meal_name_placeholder(meal_form_index)
    case meal_form_index
    when 0
      'トースト、納豆ごはん'
    when 1
      'パスタ、ラーメン'
    when 2
      'やきにく、おすし'
    end
  end

  def meal_memo_placeholder(meal_form_index)
    case meal_form_index
    when 0
      'おすすめを作ってみよう'
    when 1
      '時間がないからささっと'
    when 2
      '給料日なので外食！'
    end
  end

  def alt_meal_timing(meal_index_or_timing)
    case meal_index_or_timing
    when 0, 'breakfast'
      '朝ごはんを表す朝日のマーク'
    when 1, 'lunch'
      '昼ごはんを表す太陽のマーク'
    when 2, 'dinner'
      '夜ごはんを表す月のマーク'
    end
  end
end
