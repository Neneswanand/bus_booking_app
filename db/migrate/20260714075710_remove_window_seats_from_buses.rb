class RemoveWindowSeatsFromBuses < ActiveRecord::Migration[8.1]
  def change
    remove_column :buses, :window_seats
  end
end
