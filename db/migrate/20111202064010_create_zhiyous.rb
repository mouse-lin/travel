class CreateZhiyous < ActiveRecord::Migration
  def change
    create_table :zhiyous do |t|
      t.references :pifa
      t.references :chufa
      t.references :linename
      t.integer :days
      t.text :detail

      t.timestamps
    end
    add_index :zhiyous, :pifa_id
    add_index :zhiyous, :chufa_id
    add_index :zhiyous, :linename_id
  end
end
