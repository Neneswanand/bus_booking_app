class RemoveUidFromUsers < ActiveRecord::Migration[8.1]
  def change
    remove_column :users, :u_id
  end
end
