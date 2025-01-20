# frozen_string_literal: true

class SampleWebpushNotificationsController < ApplicationController
  include Rails.application.routes.url_helpers

  def create
    subscriptions = current_user.subscriptions
    message = {
      title: 'プッシュ通知のサンプルです',
      body: 'このようなプッシュ通知が届きます。',
      icon: "#{Rails.application.config.asset_host}/logo_icon.png",
      data: { url: root_url }
    }
    subscriptions.each do |subscription|
      WebPush.payload_send(
        endpoint: subscription.endpoint,
        message: JSON.generate(message),
        p256dh: subscription.p256dh_key,
        auth: subscription.auth_key,
        vapid: {
          public_key: Rails.application.credentials.webpush[:public_key],
          private_key: Rails.application.credentials.webpush[:private_key]
        }
      )
    rescue WebPush::ExpiredSubscription, WebPush::InvalidSubscription
      subscription.destroy!
    end
  end
end
