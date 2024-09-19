# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.references :family, null: false, foreign_key: true
      t.string :name, null: false, limit: 20
      t.string :uid, null: false
      t.string :provider, null: false
      t.integer :icon, null: false, default: 0

      t.timestamps
    end
  end
end
