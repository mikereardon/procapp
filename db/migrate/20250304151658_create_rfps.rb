class CreateRfps < ActiveRecord::Migration[7.2]
  def change
    create_table :rfps do |t|
      t.string :title
      t.text :description
      t.datetime :submission_deadline
      t.string :status
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
