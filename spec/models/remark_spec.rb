# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Remark, type: :model do
  let(:user) { create(:user) }
  let(:meal_plan) { create(:meal_plan, :with_breakfast_and_dinner, family: user.family) }
  let(:meeting_room) { create(:meeting_room, family: user.family, meal_plan:) }
  let(:proposal) { create(:remark, remark_type: 'proposal', meeting_room:, user:) }
  let(:comment) { create(:remark, remark_type: 'comment', meeting_room:, user:) }

  describe '#proposal?' do
    it 'remark_typeがproposalのときtrueを返す' do
      expect(proposal.proposal?).to be true
    end

    it 'remark_typeがcommentのときfalseを返す' do
      expect(comment.proposal?).to be false
    end
  end

  describe '#comment?' do
    it 'remark_typeがcommentのときtrueを返す' do
      expect(comment.comment?).to be true
    end

    it 'remark_typeがproposalのときtrueを返す' do
      expect(proposal.comment?).to be false
    end
  end
end
