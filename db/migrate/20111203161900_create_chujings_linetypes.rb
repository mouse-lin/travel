class CreateChujingsLinetypes < ActiveRecord::Migration
  def change
    create_table :chujings_linetypes do |t|
      t.integer :chujing_id
      t.integer :linetype_id

      t.timestamps
    end
  end
end
