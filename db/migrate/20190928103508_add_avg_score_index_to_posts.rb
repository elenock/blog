# frozen_string_literal: true

class AddAvgScoreIndexToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :avg_score, :float, default: 0.0
    add_index :posts, :avg_score
  end
end
