# frozen_string_literal: true

class CreateMeetingRooms < ActiveRecord::Migration[7.2]
  def change
    create_table :meeting_rooms do |t|
      t.references :family, null: false, foreign_key: true
      t.references :meal_plan, null: false, foreign_key: true

      t.timestamps
    end
    add_index :meeting_rooms, %i[family_id meal_plan_id], unique: true
  end
end
