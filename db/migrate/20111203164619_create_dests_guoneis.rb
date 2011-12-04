class CreateDestsGuoneis < ActiveRecord::Migration
  def change
    create_table :dests_guoneis do |t|
      t.integer :guonei_id
      t.integer :dest_id

      t.timestamps
    end
  end
end
