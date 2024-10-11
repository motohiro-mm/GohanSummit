# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :authenticate, only: :create

  def create
    user = User.find_or_new_from_auth_hash(request.env['omniauth.auth'])
    user.find_or_new_family(request.env['omniauth.params']['invitation_token']) if user.family_id.nil?
    if user.save
      session[:user_id] = user.id
      redirect_to meal_plans_path, notice: 'ログインに成功しました'
    else
      redirect_to root_path, notice: 'ログインに失敗しました'
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: 'ログアウトしました'
  end
end
