# frozen_string_literal: true

class Remark < ApplicationRecord
  belongs_to :meeting_room
  belongs_to :user

  validates :remark_type, presence: true
  validates :content, presence: true

  enum :remark_type, { proposal: 0, comment: 1 }, validate: true

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

  def broadcast_of_create(current_user)
    if proposal?
      broadcast_prepend('proposal')
    else
      broadcast_prepend('comment')
    end
    broadcast_of_edit_link(current_user)
  end

  def broadcast_of_update(current_user)
    if proposal?
      broadcast_replace('proposal')
    else
      broadcast_replace('comment')
    end
    broadcast_of_edit_link(current_user)
  end

  private

  def broadcast_prepend(type)
    broadcast_prepend_to [meeting_room, type], partial: "remarks/#{type}", locals: { remark: self }, target: "#{type}s"
  end

  def broadcast_replace(type)
    broadcast_replace_to [meeting_room, type], partial: "remarks/#{type}", locals: { remark: self }, target: "remark_#{id}"
  end

  def broadcast_of_edit_link(current_user)
    broadcast_replace_to([current_user, 'edit_link'], partial: 'remarks/edit_link', locals: { remark: self, current_user: }, target: "remark-#{id}-edit-link")
  end
end
