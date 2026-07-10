class AddRouteToBuses < ActiveRecord::Migration[8.1]
  def change
    add_reference :buses, :route, null: false, foreign_key: true
  end
end
