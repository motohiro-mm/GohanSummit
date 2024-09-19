# frozen_string_literal: true

class CreateFamilies < ActiveRecord::Migration[7.2]
  def change
    create_table :families do |t|
      t.string :invitation_token, null: false

      t.timestamps
    end
  end
end
