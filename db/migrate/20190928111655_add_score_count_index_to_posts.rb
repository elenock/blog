class AddScoreCountIndexToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :score_count, :integer, default: 0, index: true
  end
end
