class CreateGuoneifatuans < ActiveRecord::Migration
  def change
    create_table :guoneifatuans do |t|
      t.references :guonei
      t.references :star
      t.string :fatuanri
      t.integer :left
      t.integer :total
      t.integer :tonghang
      t.integer :zhike
      t.date :daystart
      t.date :dayend

      t.timestamps
    end
    add_index :guoneifatuans, :guonei_id
    add_index :guoneifatuans, :star_id
  end
end
