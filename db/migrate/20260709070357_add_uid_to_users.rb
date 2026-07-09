class AddUidToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :u_id, :string
  end
end
