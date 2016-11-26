class CreateCars < ActiveRecord::Migration[5.0]
  def change
    create_table :cars do |t|
      t.string :make, null: false
      t.string :model, null: false
      t.integer :year, null: false
      t.integer :miles, default: 0
      t.belongs_to :dealership, foreign_key: true

      t.timestamps
    end
  end
end
