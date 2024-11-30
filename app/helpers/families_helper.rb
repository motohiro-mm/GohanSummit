# frozen_string_literal: true

module FamiliesHelper
  def invitation_url(family)
    "#{welcome_url}?invitation_token=#{family.invitation_token}"
  end
end
