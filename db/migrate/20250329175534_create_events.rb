# frozen_string_literal: true

class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.datetime :date
      t.string :venue
      t.string :address

      t.timestamps
    end
  end
end
