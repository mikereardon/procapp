class CreateProposals < ActiveRecord::Migration[7.2]
  def change
    create_table :proposals do |t|
      t.references :rfp, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.string :status

      t.timestamps
    end
  end
end
