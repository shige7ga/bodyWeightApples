class ChangeHeightColumn < ActiveRecord::Migration[7.2]
  def change
    change_column :users, :height, :decimal, precision: 4, scale: 1
  end
end
