# frozen_string_literal: true

class User < ApplicationRecord
  belongs_to :family
  has_many :remarks, dependent: :nullify

  enum :icon, {
    'man.png': 0,
    'king.png': 1,
    'girl.png': 2,
    'clown.png': 3,
    'fighter.png': 4,
    'fish.png': 5,
    'eagle.png': 6,
    'apple.png': 7,
    'chimpanzee.png': 8
  }

  ICON = {
    man: 'man.png',
    king: 'king.png',
    girl: 'girl.png',
    clown: 'clown.png',
    fighter: 'fighter.png',
    eagle: 'eagle.png',
    apple: 'apple.png',
    chimpanzee: 'chimpanzee.png'
  }.freeze

  def self.find_or_new_from_auth_hash(auth_hash)
    user_params = user_params_from_auth_hash(auth_hash)
    find_or_initialize_by(uid: user_params[:uid], provider: user_params[:provider]) do |user|
      user.name = user_params[:name]
    end
  end

  def find_or_new_family(invitation_token)
    if invitation_token.present?
      family = Family.find_by!(invitation_token:)
      self.family = family
    else
      build_family(invitation_token: SecureRandom.urlsafe_base64)
    end
  end

  def self.user_params_from_auth_hash(auth_hash)
    {
      name: auth_hash.info.name,
      uid: auth_hash.uid,
      provider: auth_hash.provider
    }
  end
end
