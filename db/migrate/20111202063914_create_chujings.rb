class CreateChujings < ActiveRecord::Migration
  def change
    create_table :chujings do |t|
      t.references :pifa
      t.references :chufa
      t.references :linename
      t.integer :days
      t.text :detail

      t.timestamps
    end
    add_index :chujings, :pifa_id
    add_index :chujings, :chufa_id
    add_index :chujings, :linename_id
  end
end
