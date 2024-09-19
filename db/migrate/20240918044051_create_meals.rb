# frozen_string_literal: true

class CreateMeals < ActiveRecord::Migration[7.2]
  def change
    create_table :meals do |t|
      t.references :meal_plan, null: false, foreign_key: true
      t.string :name, null: false
      t.integer :timing, null: false
      t.text :memo, null: false

      t.timestamps
    end
    add_index :meals, %i[meal_plan_id timing], unique: true
    add_check_constraint :meals, 'timing IN (0, 1, 2)', name: 'timing_check'
  end
end
