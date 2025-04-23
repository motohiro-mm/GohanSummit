# frozen_string_literal: true

class Remark < ApplicationRecord
  belongs_to :meeting_room
  belongs_to :user

  enum :remark_type, { proposal: 0, comment: 1 }, validate: true

  validates :remark_type, presence: true
  validates :content, length: { maximum: 20, too_long: :too_long_proposal }, presence: { message: :blank_proposal }, if: :proposal?
  validates :content, length: { maximum: 50, too_long: :too_long_comment }, presence: { message: :blank_comment }, if: :comment?

  after_create_commit lambda {
    broadcast_remove_to [meeting_room, remark_type.pluralize], target: "#{remark_type}_empty_message"
    broadcast_prepend_to [meeting_room, remark_type.pluralize], partial: "remarks/#{remark_type}", locals: { remark: self }, target: remark_type.pluralize
  }
  after_update_commit -> { broadcast_replace_later_to [meeting_room, remark_type.pluralize], partial: "remarks/#{remark_type}", locals: { remark: self }, target: "remark_#{id}" }
  after_destroy_commit -> { broadcast_remove_to [meeting_room, 'remarks'] }
end
