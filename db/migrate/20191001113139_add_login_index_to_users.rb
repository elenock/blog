class AddLoginIndexToUsers < ActiveRecord::Migration[5.2]
  def change
    add_index :users, :login, unique: true
  end
end
