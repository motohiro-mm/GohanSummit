# frozen_string_literal: true

class HomeController < ApplicationController
  skip_before_action :check_logged_in, only: :index

  def index; end

  def welcome
    family = Family.find_by!(invitation_token: params[:invitation_token])
    @invitation_token = family.invitation_token
  end
end
