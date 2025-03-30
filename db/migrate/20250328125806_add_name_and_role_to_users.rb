# frozen_string_literal: true

class AddNameAndRoleToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :name, :string, null: false
    add_column :users, :role, :string, null: false
  end
end
