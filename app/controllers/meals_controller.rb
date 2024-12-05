# frozen_string_literal: true

class MealsController < ApplicationController
  def new
    @meal_plan = current_family.meal_plans.find(params[:meal_plan_id])
    @meal = Meal.build(name: @meal_plan.meeting_room.remarks.find(params[:remark]).content)
  end

  def create
    @meal_plan = current_family.meal_plans.find(meal_plan_id)
    @meal = Meal.find_or_initialize_by(meal_plan_id: @meal_plan.id, timing: meal_params[:timing])
    @meal.name = meal_params[:name]
    @meal.memo = ''
    if @meal.save(context: :save_by_proposal)
      redirect_to @meal_plan, notice: '献立を登録しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def meal_params
    params.require(:meal).permit(:timing, :name)
  end

  def meal_plan_id
    params.require(:meal_plan_id)
  end
end
