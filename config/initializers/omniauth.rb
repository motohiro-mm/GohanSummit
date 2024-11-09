# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.application.credentials.google
    provider :google_oauth2,
             Rails.application.credentials.google[:client_id],
             Rails.application.credentials.google[:client_secret]
  end
end

OmniAuth.config.on_failure = Proc.new { |env|
  OmniAuth::FailureEndpoint.new(env).redirect_to_failure
}
