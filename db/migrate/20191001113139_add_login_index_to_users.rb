# frozen_string_literal: true

class AddLoginIndexToUsers < ActiveRecord::Migration[5.2]
  def change
    add_index :users, :login, unique: true
  end
end
