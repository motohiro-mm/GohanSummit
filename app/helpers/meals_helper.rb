# frozen_string_literal: true

module MealsHelper
  def meal_timing(meal_form)
    Meal.timings.key(meal_form.index)
  end

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
      'おすすめされたトーストを作ってみよう'
    when 1
      '会社の近くでさっと食べられるもの'
    when 2
      '給料日なので外食！'
    end
  end
end
