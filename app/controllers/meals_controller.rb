# frozen_string_literal: true

class MealsController < ApplicationController
  def new
    @meal_plan = current_user.family.meal_plans.find(params[:meal_plan_id])
    @meal = Meal.build(name: @meal_plan.meeting_room.remarks.find(params[:remark]).content)
  end

  def create
    meal = Meal.build(meal_params)
    meal_plan = current_user.family.meal_plans.find(meal_plan_id)
    if meal.create_or_update_meal_name(meal_plan)
      redirect_to meal_plan, notice: '登録しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def meal_params
    params.require(:meal).permit(:id, :timing, :name, :memo)
  end

  def meal_plan_id
    params.require(:meal_plan_id)
  end
end
