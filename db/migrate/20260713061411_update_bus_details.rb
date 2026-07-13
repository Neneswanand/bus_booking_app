class UpdateBusDetails < ActiveRecord::Migration[8.1]
  def change
    add_column :buses, :bus_number, :string
    add_column :buses, :registration_number, :string
  end
end
