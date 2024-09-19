# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  include SessionsHelper
  before_action :check_logged_in

  def check_logged_in
    return if current_user

    redirect_to root_path
  end
end
