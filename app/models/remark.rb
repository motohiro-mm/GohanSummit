# frozen_string_literal: true

class Remark < ApplicationRecord
  belongs_to :meeting_room
  belongs_to :user

  validates :remark_type, presence: true
  validates :content, presence: true

  enum :remark_type, { proposal: 0, comment: 1 }, validate: true

  after_create_commit -> { broadcast_of_create }
  after_update_commit -> { broadcast_of_update }
  after_destroy_commit -> { broadcast_remove_to [meeting_room, 'remarks'] }

  def proposal?
    remark_type == 'proposal'
  end

  def comment?
    remark_type == 'comment'
  end

  def editable?(target_user)
    user == target_user
  end

  private

  def broadcast_of_create
    if proposal?
      broadcast_prepend_to [meeting_room, 'proposal'], partial: 'remarks/proposal', locals: { remark: self }, target: 'proposals'
    else
      broadcast_prepend_to [meeting_room, 'comment'], partial: 'remarks/comment', locals: { remark: self }, target: 'comments'
    end
  end

  def broadcast_of_update
    if proposal?
      broadcast_replace_to [meeting_room, 'proposal'], partial: 'remarks/proposal', locals: { remark: self }, target: "remark_#{id}"
    else
      broadcast_replace_to [meeting_room, 'comment'], partial: 'remarks/comment', locals: { remark: self }, target: "remark_#{id}"
    end
  end
end
