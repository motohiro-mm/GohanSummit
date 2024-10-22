# frozen_string_literal: true

module MealPlansHelper
  def meal_timing(meal_form)
    Meal.timings.key(meal_form.index)
  end

  def button_display
    if action_name == 'new'
      I18n.t 'helpers.submit.create'
    elsif action_name == 'edit'
      I18n.t 'helpers.submit.update'
    end
  end
end
