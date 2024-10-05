# frozen_string_literal: true

module MealPlansHelper
  def meal_timing(meal_form)
    Meal.timings.key(meal_form.index)
  end
end
