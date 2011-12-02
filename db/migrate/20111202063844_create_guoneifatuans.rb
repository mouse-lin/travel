class CreateGuoneifatuans < ActiveRecord::Migration
  def change
    create_table :guoneifatuans do |t|
      t.references :guonei
      t.string :fatuanri
      t.references :star
      t.integer :left
      t.integer :total
      t.integer :tonghang
      t.integer :zhike
      t.time :daystart
      t.time :dayend

      t.timestamps
    end
    add_index :guoneifatuans, :guonei_id
    add_index :guoneifatuans, :star_id
  end
end
