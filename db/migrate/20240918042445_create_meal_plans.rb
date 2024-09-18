# frozen_string_literal: true

class CreateMealPlans < ActiveRecord::Migration[7.2]
  def change
    create_table :meal_plans do |t|
      t.date :meal_date, null: false
      t.references :family, null: false, foreign_key: true

      t.timestamps
    end
    add_index :meal_plans, %i[family_id meal_date], unique: true
  end
end
