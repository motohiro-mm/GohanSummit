# frozen_string_literal: true

class Family < ApplicationRecord
  include Rails.application.routes.url_helpers

  has_many :users, dependent: :destroy
  has_many :meal_plans, dependent: :destroy
  has_many :meeting_rooms, dependent: :destroy
  has_many :subscriptions, through: :users

  validates :invitation_token, presence: true, uniqueness: true

  def destroy_having_no_user
    return if users.exists?

    Family.find(id).destroy
  end

  def send_remark_notifications(remark)
    remark_type_ja = I18n.t("activerecord.attributes.remark/remark_type.#{remark.remark_type}")
    message = {
      title: "家族が#{remark_type_ja}しました",
      body: "#{remark.meeting_room.meal_plan_date}の会議室を確認しましょう！",
      icon: "#{Rails.application.config.asset_host}/logo_icon.png",
      data: {
        url: "#{Rails.application.config.asset_host}/meeting_rooms/#{remark.meeting_room_id}",
        remark_id: remark.id
      }
    }
    subscriptions_except_author = subscriptions.reject { |subscription| subscription.user == remark.user }
    subscriptions_except_author.each do |subscription|
      subscription.send_webpush!(message)
    rescue WebPush::ExpiredSubscription
      subscription.destroy!
      next
    end
  end
end
