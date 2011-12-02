class CreateGuoneis < ActiveRecord::Migration
  def change
    create_table :guoneis do |t|
      t.references :pifa
      t.references :chufa
      t.references :linename
      t.integer :days
      t.text :detail

      t.timestamps
    end
    add_index :guoneis, :pifa_id
    add_index :guoneis, :chufa_id
    add_index :guoneis, :linename_id
  end
end
