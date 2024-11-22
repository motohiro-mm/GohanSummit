# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HomeHelper, type: :helper do
  describe '#google_oauth2_path' do
    it 'invitation_tokenがないとき短いパスを返す' do
      expect(google_oauth2_path).to eq '/auth/google_oauth2'
    end

    it 'invitation_tokenがあるときinvitation_tokenを含んだパスを返す' do
      expect(google_oauth2_path('test123token')).to eq '/auth/google_oauth2/?invitation_token=test123token'
    end
  end
end
