# frozen_string_literal: true

FactoryBot.define do
  factory :remark do
    user
    meeting_room
    content { 'RemarkContent' }
  end
end
