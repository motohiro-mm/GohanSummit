# frozen_string_literal: true

class HomeController < ApplicationController
  skip_before_action :check_logged_in, only: :index

  def index; end
end
