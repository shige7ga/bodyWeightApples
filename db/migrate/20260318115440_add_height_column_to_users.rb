class AddHeightColumnToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :height, :integer
  end
end
