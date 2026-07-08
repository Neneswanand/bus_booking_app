class CreateBuses < ActiveRecord::Migration[8.1]
  def change
    create_table :buses do |t|
      t.integer :bus_rn
      t.string :bus_no

      t.string :source
      t.string :destination
      t.string :departure_time
      t.decimal :price
      t.integer :total_seats
      t.integer :available_seats
      t.integer :window_seats

      t.timestamps
    end
  end
end
