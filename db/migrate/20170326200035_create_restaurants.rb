class CreateRestaurants < ActiveRecord::Migration[5.0]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :location
      t.string :open_hour
      t.string :close_hour

      t.timestamps
    end
  end
end
