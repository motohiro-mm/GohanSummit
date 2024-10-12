# frozen_string_literal: true

class Remark < ApplicationRecord
  belongs_to :meeting_room
  belongs_to :user

  validates :remark_type, presence: true
  validates :content, presence: true

  enum :remark_type, { proposal: 0, comment: 1 }, validate:true

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
