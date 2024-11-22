# frozen_string_literal: true

class AddLimitToRemarks < ActiveRecord::Migration[7.2]
  def up
    change_column :remarks, :content, :string, limit: 50
  end
end
