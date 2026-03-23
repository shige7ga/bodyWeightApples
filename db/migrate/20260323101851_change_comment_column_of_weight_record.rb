class ChangeCommentColumnOfWeightRecord < ActiveRecord::Migration[7.2]
  def change
    rename_column :weight_records, :comment, :memo
  end
end
