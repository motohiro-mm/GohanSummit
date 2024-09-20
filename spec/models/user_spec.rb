require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.create(:user, family: FactoryBot.create(:family))
    @auth_struct = Struct.new(:info, :uid, :provider)
    @info_name = Struct.new(:name)
  end

  describe '.find_or_new_from_auth_hash' do
    it 'ユーザーが存在する場合に保存されているユーザーを返す' do
      auth_hash = @auth_struct.new(info: @info_name.new(name: @user.name), uid: @user.uid, provider: @user.provider)
      expect(User.find_or_new_from_auth_hash(auth_hash)).to eq @user
    end

    it 'ユーザーが存在しない場合に新しいユーザーを作成して保存せずに返す' do
      new_auth_hash = @auth_struct.new(info: @info_name.new(name: 'new_test_name'), uid: 'new1234', provider: 'x')
      new_user = User.find_or_new_from_auth_hash(new_auth_hash)
      expect(new_user).to be_instance_of(User)
      expect(new_user).not_to be_persisted
    end
  end

  describe '#find_or_new_family' do
    it 'invitation_tokenがあるとき該当するfamilyをnew_userのfamilyにいれる' do
      new_user = FactoryBot.build(:user)
      new_user.find_or_new_family(@user.family.invitation_token)
      expect(new_user.family).to eq @user.family
    end

    it 'invitation_tokenがないときfamilyを新規作成しnew_userのfamilyにいれる' do
      new_user = FactoryBot.build(:user)
      new_user.find_or_new_family(nil)
      expect(new_user.family).to be_instance_of(Family)
      expect(new_user.family).not_to be_persisted
    end
  end
end
