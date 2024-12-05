# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationCable::Connection, type: :channel do
  it 'sessionのuser_idが有効のとき、Connectionのcurrent_userはuserが返る' do
    user = create(:user)
    connect '/cable', session: { user_id: user.id }
    expect(connection.current_user).to eq(user)
  end

  it 'sessionのuser_idが存在しないidのとき、' do
    expect { connect '/cable', session: { user_id: -1 } }.to raise_error ActionCable::Connection::Authorization::UnauthorizedError
  end

  it 'sessionのuser_idがnilのとき、' do
    expect { connect '/cable', session: { user_id: nil } }.to raise_error ActionCable::Connection::Authorization::UnauthorizedError
  end
end
