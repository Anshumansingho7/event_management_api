# frozen_string_literal: true

class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false
      t.datetime :date, null: false
      t.string :venue, null: false
      t.string :address, null: false

      t.timestamps
    end
  end
end
