class CreateGuoneisLinetypes < ActiveRecord::Migration
  def change
    create_table :guoneis_linetypes do |t|
      t.integer :guonei_id
      t.integer :linetype_id

      t.timestamps
    end
  end
end
