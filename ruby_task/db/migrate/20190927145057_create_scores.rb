# frozen_string_literal: true

class CreateScores < ActiveRecord::Migration[5.2]
  def change
    create_table :scores do |t|
      t.integer :level

      t.references :post, foreign_key: true

      t.timestamps
    end
  end
end
