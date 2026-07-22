class RemoveColumnFromRoutes < ActiveRecord::Migration[8.1]
  def change
    remove_column :routes, :via, :string
  end
end
