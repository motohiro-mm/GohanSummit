# frozen_string_literal: true

module HomeHelper
  def google_oauth2_path(invitation_token = nil)
    if invitation_token
      "/auth/google_oauth2/?invitation_token=#{invitation_token}"
    else
      '/auth/google_oauth2'
    end
  end
end
