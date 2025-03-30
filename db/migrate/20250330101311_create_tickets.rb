# frozen_string_literal: true

class CreateTickets < ActiveRecord::Migration[7.1]
  def change
    create_table :tickets do |t|
      t.string :ticket_type
      t.references :event, null: false, foreign_key: true
      t.decimal :price, null: false, default: 0
      t.integer :ticket_count, null: false, default: 0
      t.integer :total_booked, null: false, default: 0

      t.timestamps
    end
  end
end
