# frozen_string_literal: true

class Remark < ApplicationRecord
  belongs_to :meeting_room
  belongs_to :user

  validates :remark_type, presence: true
  validates :content, presence: true

  enum :remark_type, { proposal: 0, comment: 1 }, validate: true

  scope :proposals, -> { where(remark_type: 'proposal') }
  scope :comments, -> { where(remark_type: 'comment') }

  after_destroy_commit -> { broadcast_remove_to [meeting_room, 'remarks'] }

  def proposal?
    remark_type == 'proposal'
  end

  def comment?
    remark_type == 'comment'
  end


  def broadcast_of_create(current_user)
    broadcast_remove_empty_message(remark_type)
    if proposal?
      broadcast_prepend('proposal')
    else
      broadcast_prepend('comment')
    end
  end

  def broadcast_of_update(current_user)
    if proposal?
      broadcast_replace('proposal')
    else
      broadcast_replace('comment')
    end
  end

  private

  def broadcast_remove_empty_message(type)
    broadcast_remove_to [meeting_room, "#{type}s"], target: "#{type}_empty_message"
  end

  def broadcast_prepend(type)
    broadcast_prepend_later_to [meeting_room, "#{type}s"], partial: "remarks/#{type}", locals: { remark: self }, target: "#{type}s"
  end

  def broadcast_replace(type)
    broadcast_replace_later_to [meeting_room, "#{type}s"], partial: "remarks/#{type}", locals: { remark: self }, target: "remark_#{id}"
  end
end
