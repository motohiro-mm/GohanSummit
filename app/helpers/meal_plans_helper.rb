# frozen_string_literal: true

module MealPlansHelper
  def meal_timing(meal_form)
    Meal.timings.key(meal_form.index)
  end

  def new_or_edit_meal_plan_path(meal_plan, date)
    meal_plan ? edit_meal_plan_path(meal_plan) : new_meal_plan_path(meal_date: date)
  end
end
