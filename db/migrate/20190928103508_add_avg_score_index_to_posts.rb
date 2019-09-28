class AddAvgScoreIndexToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :avg_score, :float, default: 0.0, index: true
  end
end
