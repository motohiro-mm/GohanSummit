# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FamiliesHelper, type: :helper do
  describe '#invitation_url' do
    it '招待用URLを返す' do
      expect(invitation_url(create(:family))).to eq 'http://test.host/welcome?invitation_token=test123family_token'
    end
  end
end
