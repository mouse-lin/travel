class CreateDestsZhiyous < ActiveRecord::Migration
  def change
    create_table :dests_zhiyous do |t|
      t.integer :zhiyou_id
      t.integer :dest_id

      t.timestamps
    end
  end
end
