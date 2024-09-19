# frozen_string_literal: true

class CreateRemarks < ActiveRecord::Migration[7.2]
  def change
    create_table :remarks do |t|
      t.references :user, null: false, foreign_key: true
      t.references :meeting_room, null: false, foreign_key: true
      t.integer :remark_type, null: false
      t.string :content, null: false

      t.timestamps
    end
    add_check_constraint :remarks, 'remark_type IN (0, 1)', name: 'remark_type_check'
  end
end
