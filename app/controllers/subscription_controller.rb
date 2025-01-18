# frozen_string_literal: true

class SubscriptionController < ApplicationController
  def create
    Subscription.create!(
      user: current_user,
      endpoint: subscription_params[:endpoint],
      auth_key: subscription_params[:keys][:auth],
      p256dh_key: subscription_params[:keys][:p256dh]
    )
  end

  private

  def subscription_params
    params.require(:subscription).permit(:endpoint, keys: %i[auth p256dh])
  end
end
