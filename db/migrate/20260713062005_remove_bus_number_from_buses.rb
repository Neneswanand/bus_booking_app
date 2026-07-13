class RemoveBusNumberFromBuses < ActiveRecord::Migration[8.1]
  def change
    remove_column :buses, :bus_number
  end
end
