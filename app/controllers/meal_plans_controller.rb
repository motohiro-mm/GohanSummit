# frozen_string_literal: true

class MealPlansController < ApplicationController
  before_action :set_meal_plan, only: %i[show edit update destroy]

  def index
    @meal_plans = current_user.family.meal_plans.includes([:meals])
  end

  def show; end

  def new
    @meal_plan = current_user.family.meal_plans.find_or_initialize_by(meal_date: params[:meal_date])
    @meal_plan.meals_build
  end

  def edit
    @meal_plan.meals_build
  end

  def create
    @meal_plan = current_user.family.meal_plans.find_or_initialize_by(meal_date: meal_plan_params[:meal_date])
    @meal_plan.assign_attributes(meal_plan_params)

    if @meal_plan.save
      redirect_to @meal_plan, notice: '献立を作成しました'
    else
      @meal_plan.meals_build
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @meal_plan.update_meal_plan(meal_plan_params)
      redirect_to @meal_plan, notice: '更新しました'
    else
      @meal_plan.meals_build
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @meal_plan.meals.each(&:destroy!)
    redirect_to meal_plans_path(meal_date: @meal_plan.meal_date), notice: '削除しました', status: :see_other
  end

  def calendar
    @meal_plans = current_user.family.meal_plans.includes([:meals])
  end

  private

  def set_meal_plan
    @meal_plan = current_user.family.meal_plans.find(params[:id])
  end

  def meal_plan_params
    params.require(:meal_plan).permit(:meal_date, meals_attributes: %i[id name memo timing])
  end
end
