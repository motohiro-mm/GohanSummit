# frozen_string_literal: true

module LoginSupport
  def log_in_as(user)
    OmniAuth.configure do |config|
      config.test_mode = true
      config.mock_auth[:google_oauth2] =
        OmniAuth::AuthHash.new({
                                 provider: user.provider,
                                 uid: user.uid,
                                 info: { name: user.name }
                               })
    end
    visit root_path
    click_button 'Googleでログイン'
  end
end
