class CreateRfpInterests < ActiveRecord::Migration[7.2]
  def change
    create_table :rfp_interests do |t|
      t.references :rfp, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
