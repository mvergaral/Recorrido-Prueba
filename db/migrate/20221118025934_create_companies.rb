class CreateCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.jsonb :schedule

      t.timestamps
    end
  end
end
