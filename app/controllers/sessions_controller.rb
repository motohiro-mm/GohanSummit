# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :check_logged_in, only: :create

  def create
    user = User.find_or_new_from_auth_hash(request.env['omniauth.auth'])
    user.find_or_create_family(request.env["omniauth.params"]["invitation_token"]) if user.family_id.nil?
    if user.save
      log_in user
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end
end
