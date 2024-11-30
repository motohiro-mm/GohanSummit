# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Family, type: :model do
  let(:family) { create(:family, invitation_token: 'test_token') }
  let(:user) { create(:user, family: family) }

  describe '#destroy_family_having_no_user' do
    it '同じ家族のユーザーが存在するので家族を削除しない' do
      user
      family.destroy_family_having_no_user
      expect(Family.find_by(id: family.id)).to eq family
    end

    it '同じ家族のユーザーが存在しないので家族を削除する' do
      family.destroy_family_having_no_user
      expect(Family.find_by(id: family.id)).to be_nil
    end
  end
end
