class CreateTurnAvailabilities < ActiveRecord::Migration[7.0]
  def change
    create_table :turn_availabilities do |t|
      t.datetime :date
      t.references :engineer, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true
      t.references :turn, null: false, foreign_key: true
      t.boolean :available

      t.timestamps
    end
  end
end
