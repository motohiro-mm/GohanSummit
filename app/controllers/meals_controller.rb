# frozen_string_literal: true

class MealsController < ApplicationController
  def new
    @meal_plan = current_user.family.meal_plans.find(params[:meal_plan_id])
    @meal = Meal.build(name: @meal_plan.meeting_room.remarks.find(params[:remark]).content)
  end
end
