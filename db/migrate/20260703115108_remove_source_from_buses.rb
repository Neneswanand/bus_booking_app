class RemoveSourceFromBuses < ActiveRecord::Migration[8.1]
  def change
    remove_column :buses, :source, :string
    remove_column :buses, :destination, :string
  end
end
