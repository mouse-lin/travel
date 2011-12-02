class CreateDests < ActiveRecord::Migration
  def change
    create_table :dests do |t|
      t.string :name
      t.references :destcat

      t.timestamps
    end
    add_index :dests, :destcat_id
  end
end
