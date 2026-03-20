class CreateWeightRecords < ActiveRecord::Migration[7.2]
  def change
    create_table :weight_records do |t|
      t.decimal :weight, precision: 6, scale: 2, null: false
      t.string :comment, null: true
      t.references :user, null: true, foreign_key: true

      t.timestamps
    end
  end
end
