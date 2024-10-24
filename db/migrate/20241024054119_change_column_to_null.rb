# frozen_string_literal: true

class ChangeColumnToNull < ActiveRecord::Migration[7.2]
  def up
    change_column_null :remarks, :user_id, true
  end

  def down
    change_column_null :remarks, :user_id, false
  end
end
