class AddColumnToBuses < ActiveRecord::Migration[8.1]
  def change
    add_column :buses, :bus_number, :string
  end
end
