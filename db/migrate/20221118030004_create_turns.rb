class CreateTurns < ActiveRecord::Migration[7.0]
  def change
    create_table :turns do |t|
      t.datetime :date
      t.references :engineer, null: true, foreign_key: false
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
