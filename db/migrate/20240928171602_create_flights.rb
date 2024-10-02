class CreateFlights < ActiveRecord::Migration[7.2]
  def change
    create_table :flights do |t|
      t.datetime :date
      t.string :name
      t.references :departure, null: false, foreign_key: {to_table: :airports}
      t.references :arrival, null: false, foreign_key: {to_table: :airports}
      t.integer :vacancy

      t.timestamps
    end
  end
end
