# frozen_string_literal: true

module MealPlansHelper
  def meal_timing(meal_form)
    Meal.timings.key(meal_form.index)
  end

  def button_display
    if action_name == 'new'
      '登録'
    elsif action_name == 'edit'
      '更新'
    end
  end
end
