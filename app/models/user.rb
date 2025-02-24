# frozen_string_literal: true

class User < ApplicationRecord
  belongs_to :family
  has_many :remarks, dependent: :nullify

  has_many :subscriptions, dependent: :destroy

  validates :name, presence: true
  validates :name, length: { maximum: 20 }

  enum :icon, {
    'chimpanzee.png': 0,
    'dog.png': 1,
    'cat.png': 2,
    'pig.png': 3,
    'rabbit.png': 4,
    'panda.png': 5,
    'tiger.png': 6,
    'cow.png': 7,
    'raccoon.png': 8,
    'fox.png': 9,
    'penguin.png': 10,
    'crocodile.png': 11
  }, validate: true

  ICON = {
    'chimpanzee.png': 'チンパンジー',
    'dog.png': 'イヌ',
    'cat.png': 'ネコ',
    'pig.png': 'ブタ',
    'rabbit.png': 'ウサギ',
    'panda.png': 'パンダ',
    'tiger.png': 'トラ',
    'cow.png': 'ウシ',
    'raccoon.png': 'アライグマ',
    'fox.png': 'キツネ',
    'penguin.png': 'ペンギン',
    'crocodile.png': 'ワニ'
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
      name: auth_hash[:info][:name],
      uid: auth_hash[:uid],
      provider: auth_hash[:provider]
    }
  end
end
