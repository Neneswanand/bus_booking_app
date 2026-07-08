class CreateBookings < ActiveRecord::Migration[8.1]
  def change
    create_table :bookings do |t|
      t.integer :seats
      t.decimal :total_price
      t.references :user, null: false, foreign_key: true
      t.references :bus, null: false, foreign_key: true

      t.timestamps
    end
  end
end
