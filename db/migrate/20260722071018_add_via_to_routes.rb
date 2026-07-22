class AddViaToRoutes < ActiveRecord::Migration[8.1]
  def change
    add_column :routes, :via, :string, array: true, default:[]
  end
end
