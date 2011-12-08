class CreateDestsLines < ActiveRecord::Migration
  def change
    create_table :dests_lines do |t|
      t.integer :dest_id
      t.integer :line_id

      t.timestamps
    end
  end
end
