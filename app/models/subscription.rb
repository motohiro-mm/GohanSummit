# frozen_string_literal: true

class Subscription < ApplicationRecord
  belongs_to :user

  def send_webpush!(message)
    WebPush.payload_send(
      endpoint: endpoint,
      message: JSON.generate(message),
      p256dh: p256dh_key,
      auth: auth_key,
      vapid: {
        public_key: Rails.application.credentials.webpush[:public_key],
        private_key: Rails.application.credentials.webpush[:private_key]
      }
    )
  end
end
