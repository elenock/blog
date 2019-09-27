# frozen_string_literal: true

class CreateMarks < ActiveRecord::Migration[5.2]
  def change
    create_table :marks do |t|
      t.integer :level

      t.references :post, foreign_key: true

      t.timestamps
    end
  end
end
