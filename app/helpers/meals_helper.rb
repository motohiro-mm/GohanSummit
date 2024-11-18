# frozen_string_literal: true

module MealsHelper
  def meal_timing(meal_form)
    Meal.timings.key(meal_form.index)
  end

  def meal_name_placeholder(meal_form_index)
    if meal_form_index == 0
      'トースト、納豆ごはん'
    elsif meal_form_index == 1
      'パスタ、ラーメン'
    elsif meal_form_index == 2
      'やきにく、おすし'
    end
  end

  def meal_memo_placeholder(meal_form_index)
    if meal_form_index == 0
      'おすすめされたトーストを作ってみよう'
    elsif meal_form_index == 1
      '会社の近くでさっと食べられるもの'
    elsif meal_form_index == 2
      '給料日なので外食！'
    end
  end
end
