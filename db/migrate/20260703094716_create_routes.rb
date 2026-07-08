class CreateRoutes < ActiveRecord::Migration[8.1]
  def change
    create_table :routes do |t|
      t.string :source
      t.string :destination
      t.integer :distance

      t.timestamps
    end
  end
end
