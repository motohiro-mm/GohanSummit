# frozen_string_literal: true

class AddIndexToFamilies < ActiveRecord::Migration[7.2]
  def up
    add_index :families, :invitation_token
  end
end
