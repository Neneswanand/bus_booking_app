class RemoveBusIdFromBuses < ActiveRecord::Migration[8.1]
  def change
    remove_column :buses, :bus_id
  end
end
