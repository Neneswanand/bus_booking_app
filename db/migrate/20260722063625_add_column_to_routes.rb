class AddColumnToRoutes < ActiveRecord::Migration[8.1]
  def change
    add_column :routes, :via, :string
  end
end
