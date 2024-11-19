# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :authenticate, only: %i[create auth_failure]

  def create
    user = User.find_or_new_from_auth_hash(request.env['omniauth.auth'])
    user.find_or_new_family(request.env['omniauth.params']['invitation_token']) if user.family_id.nil?
    session[:welcome_modal] = true if user.new_record?
    if user.save
      session[:user_id] = user.id
      redirect_to meal_plans_path, notice: 'ログインしました', status: :see_other
    else
      redirect_to root_path, alert: 'ログインに失敗しました'
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: 'ログアウトしました', status: :see_other
  end

  def auth_failure
    redirect_to root_path, alert: 'Googleログインがキャンセルされました'
  end
end
