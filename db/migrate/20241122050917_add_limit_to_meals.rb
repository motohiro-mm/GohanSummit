# frozen_string_literal: true

class AddLimitToMeals < ActiveRecord::Migration[7.2]
  def up
    change_column  :meals, :name, :string, limit: 20
    change_column  :meals, :memo, :string, limit: 200
  end
end
