# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update destroy]
  def edit; end

  def update
    if @user.update(user_params)
      redirect_to meal_plans_path, notice: 'ユーザーを更新しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    current_user.destroy!
    current_user.family.destroy_family_having_no_user
    reset_session
    redirect_to root_path, notice: 'ユーザーを削除しました', status: :see_other
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:name, :icon)
  end
end
