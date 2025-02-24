# frozen_string_literal: true

class MealPlansController < ApplicationController
  before_action :meal_plans_params_check, only: :index
  before_action :set_meal_plan, only: %i[show edit update destroy]

  def index
    start_date = params.fetch(:start_date, Time.zone.today).to_date
    @meal_plans = current_family.meal_plans.where(meal_date: start_date.all_week).includes([:meals]).includes([:meeting_room])
  end

  def show; end

  def new
    @meal_plan = current_family.meal_plans.find_or_initialize_by(meal_date: params[:meal_date])
    @meal_plan.meals_build
  end

  def edit
    @meal_plan.meals_build
  end

  def create
    @meal_plan = current_family.meal_plans.find_or_initialize_by(meal_date: meal_plan_params[:meal_date])
    @meal_plan.assign_attributes(meal_plan_params)

    if @meal_plan.save(context: :operate_including_meals)
      redirect_to @meal_plan, notice: '献立を作成しました'
    else
      @meal_plan.meals_build
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @meal_plan.update_meal_plan(meal_plan_params)
      redirect_to @meal_plan, notice: '献立を更新しました'
    else
      @meal_plan.meals_build
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @meal_plan.meals.each(&:destroy!)
    redirect_to meal_plans_path(meal_date: @meal_plan.meal_date), notice: '献立を削除しました', status: :see_other
  end

  def calendar
    @meal_plans = current_family.meal_plans.includes([:meals])
  end

  private

  def set_meal_plan
    @meal_plan = current_family.meal_plans.find(params[:id])
  end

  def meal_plan_params
    params.require(:meal_plan).permit(:meal_date, meals_attributes: %i[id name memo timing])
  end

  RANGE_YEAR = 30

  def meal_plans_params_check
    fetch_date = params.fetch(:start_date, Time.zone.today).to_date
    lower_date = Time.zone.today.advance(years: - RANGE_YEAR)
    upper_date = Time.zone.today.advance(years: RANGE_YEAR)
    return if (lower_date..upper_date).cover?(fetch_date)

    params[:start_date] = fetch_date.clamp(lower_date, upper_date)
    redirect_to meal_plans_path(start_date: params[:start_date]), alert: "日時は±#{RANGE_YEAR}年の範囲で指定できます"
  end
end
