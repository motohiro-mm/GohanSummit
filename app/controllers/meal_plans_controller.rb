# frozen_string_literal: true

class MealPlansController < ApplicationController
  before_action :set_meal_plan, only: %i[show edit update destroy]

  def index
    @meal_plans = current_user.family.meal_plans
  end

  def show; end

  def new
    @meal_plan = MealPlan.new
    @meal_plan.meal_date = params[:meal_date]
    3.times { @meal_plan.meals.build }
  end

  def edit; end

  def create
    @meal_plan = current_user.family.meal_plans.new(meal_plan_params)

    if @meal_plan.save
      redirect_to @meal_plan, notice: 'MealPlan was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @meal_plan.update(meal_plan_params)
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
    @meal_plan = MealPlan.find(params[:id])
  end

  def meal_plan_params
    params.require(:meal_plan).permit(:meal_date, meals_attributes: %i[id name memo timing])
  end
end
