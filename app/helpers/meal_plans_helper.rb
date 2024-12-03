# frozen_string_literal: true

module MealPlansHelper
  def form_url(meal_plan)
    if action_name_new_or_create?
      meal_plans_path
    else
      meal_plan_path(meal_plan)
    end
  end

  def form_method
    if action_name_new_or_create?
      :post
    else
      :patch
    end
  end

  def button_display
    if action_name_new_or_create?
      I18n.t 'helpers.submit.create'
    else
      I18n.t 'helpers.submit.update'
    end
  end

  private

  def action_name_new_or_create?
    action_name == 'new' || action_name == 'create'
  end
end
