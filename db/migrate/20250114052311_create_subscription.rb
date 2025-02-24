# frozen_string_literal: true

class CreateSubscription < ActiveRecord::Migration[7.2]
  def change
    create_table :subscriptions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :endpoint, null: false
      t.string :auth_key, null: false
      t.string :p256dh_key, null: false

      t.timestamps
    end
  end
end
