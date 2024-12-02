# frozen_string_literal: true

module MealPlansHelper
  def meal_plan_link(meal_plan, date)
    if meal_plan&.meals.blank?
      new_meal_plan_path(meal_date: date)
    else
      meal_plan
    end
  end

  def counter_number_color(meal_plan)
    if meals_length(meal_plan).zero?
      'text-red-400'
    elsif meals_length(meal_plan) < 3
      'text-red-700'
    else
      'text-red-950/70'
    end
  end

  def meals_length(meal_plan)
    meal_plan&.meals&.length.to_i
  end

  def proposals_length(meal_plan)
    meal_plan&.meeting_room&.remarks&.proposals&.length.to_i
  end

  def comments_length(meal_plan)
    meal_plan&.meeting_room&.remarks&.comments&.length.to_i
  end

  def button_display
    if action_name == 'new'
      I18n.t 'helpers.submit.create'
    elsif action_name == 'edit'
      I18n.t 'helpers.submit.update'
    end
  end
end
