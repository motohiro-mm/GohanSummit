# frozen_string_literal: true

class SampleWebpushNotificationsController < ApplicationController
  def create
    subscriptions = current_user.subscriptions
    message = {
      title: 'プッシュ通知のサンプルです',
      body: 'このようなプッシュ通知が届きます。',
      icon: "#{request.base_url}/logo_icon.png",
      data: { url: 'https://gohansummit.com' }
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
