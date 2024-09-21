# frozen_string_literal: true

class ChangeColumnToAllowNull < ActiveRecord::Migration[7.2]
  def change
    change_column_null :meals, :name, true
    change_column_null :meals, :memo, true
  end
end
