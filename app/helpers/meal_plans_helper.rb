# frozen_string_literal: true

module MealPlansHelper
  def meals_sort_by_timing(meal_plan)
    meal_plan.meals.sort_by { |meal| Meal.timings[meal.timing] }
  end

  def button_display
    if action_name == 'new'
      I18n.t 'helpers.submit.create'
    elsif action_name == 'edit'
      I18n.t 'helpers.submit.update'
    end
  end
end
