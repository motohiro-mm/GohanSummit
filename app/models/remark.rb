# frozen_string_literal: true

class Remark < ApplicationRecord
  belongs_to :meeting_room
  belongs_to :user

  enum :remark_type, { proposal: 0, comment: 1 }

  def proposal?
    remark_type == 'proposal'
  end

  def comment?
    remark_type == 'comment'
  end

  def editable?(target_user)
    user == target_user
  end
end
