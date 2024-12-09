# frozen_string_literal: true

class AddUniqIndexToFamilies < ActiveRecord::Migration[7.2]
  def up
    remove_index :families, :invitation_token
    add_index :families, :invitation_token, unique: true
  end
end
