class AddDetailsToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :phone, :string
    add_column :users, :age, :integer
    add_column :users, :gender, :string
  end
end
