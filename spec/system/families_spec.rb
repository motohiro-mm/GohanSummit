# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Families', type: :system do
  let(:family) { create(:family, invitation_token: 'test_token') }
  let(:user) { create(:user, family: family, name: 'TestUser') }
  let(:partner) { create(:user, family: family, name: 'TestPartner') }

  before do
    log_in_as user
  end

  it '共有用URLをコピーする', :js do
    visit family_path

    click_on '共有用URLをコピー'

    expect(page.driver.browser.switch_to.alert.text).to eq '共有用URLをコピーしました！'
  end

  it '共有しているユーザーを表示する' do
    partner
    visit family_path

    expect(page).to have_content 'TestUser'
    expect(page).to have_content 'TestPartner'
  end
end
