# frozen_string_literal: true

class Remark < ApplicationRecord
  belongs_to :meeting_room
  belongs_to :user

  enum :remark_type, { proposal: 0, comment: 1 }, validate: true

  validates :remark_type, presence: true
  validates :content, length: { maximum: 20, too_long: :too_long_proposal }, presence: { message: :blank_proposal }, if: :proposal?
  validates :content, length: { maximum: 50, too_long: :too_long_comment }, presence: { message: :blank_comment }, if: :comment?

  scope :proposals, -> { where(remark_type: 'proposal').order(created_at: :desc) }
  scope :comments, -> { where(remark_type: 'comment').order(created_at: :desc) }

  after_create_commit lambda {
    broadcast_remove_to [meeting_room, "#{remark_type}s"], target: "#{remark_type}_empty_message"
    broadcast_prepend_later_to [meeting_room, "#{remark_type}s"], partial: "remarks/#{remark_type}", locals: { remark: self }, target: "#{remark_type}s"
  }
  after_update_commit -> { broadcast_replace_later_to [meeting_room, "#{remark_type}s"], partial: "remarks/#{remark_type}", locals: { remark: self }, target: "remark_#{id}" }
  after_destroy_commit -> { broadcast_remove_to [meeting_room, 'remarks'] }

  def proposal?
    remark_type == 'proposal'
  end

  def comment?
    remark_type == 'comment'
  end
end
