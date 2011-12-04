class CreateChujingsDests < ActiveRecord::Migration
  def change
    create_table :chujings_dests do |t|
      t.integer :chujing_id
      t.integer :dest_id

      t.timestamps
    end
  end
end
