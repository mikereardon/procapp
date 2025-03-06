class CreateLineItems < ActiveRecord::Migration[7.2]
  def change
    create_table :line_items do |t|
      t.references :proposal, null: false, foreign_key: true
      t.string :description
      t.decimal :quantity
      t.decimal :unit_price

      t.timestamps
    end
  end
end
