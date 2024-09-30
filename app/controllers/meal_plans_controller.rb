# frozen_string_literal: true

class MealPlansController < ApplicationController
  before_action :set_meal_plan, only: %i[show edit update destroy]

  def index
    @meal_plans = current_user.family.meal_plans
  end

  def show; end

  def new
    @meal_plan = MealPlan.build(meal_date: params[:meal_date])
    @meal_plan.meals_build
  end

  def edit
    @meal_plan.meals_build if @meal_plan.meals.blank?
  end

  def create
    @meal_plan = current_user.family.meal_plans.build(meal_plan_params)

    if @meal_plan.save
      redirect_to @meal_plan, notice: 'MealPlan was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @meal_plan.update_meal_plan(meal_plan_params)
      redirect_to @meal_plan, notice: 'MealPlan was successfully updated.', status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @meal_plan.destroy!
    redirect_to meal_plans_path, notice: 'MealPlan was successfully destroyed.', status: :see_other
  end

  def calendar
    @meal_plans = current_user.family.meal_plans
  end

  private

  def set_meal_plan
    @meal_plan = current_user.family.meal_plans.find(params[:id])
  end

  def meal_plan_params
    params.require(:meal_plan).permit(:meal_date, meals_attributes: %i[id name memo timing])
  end
end
