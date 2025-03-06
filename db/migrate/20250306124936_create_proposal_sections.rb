class CreateProposalSections < ActiveRecord::Migration[7.2]
  def change
    create_table :proposal_sections do |t|
      t.references :proposal, null: false, foreign_key: true
      t.string :title
      t.integer :position

      t.timestamps
    end
  end
end
