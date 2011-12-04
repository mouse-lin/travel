class CreateDestsQianzhengs < ActiveRecord::Migration
  def change
    create_table :dests_qianzhengs do |t|
      t.integer :qianzheng_id
      t.integer :dest_id

      t.timestamps
    end
  end
end
