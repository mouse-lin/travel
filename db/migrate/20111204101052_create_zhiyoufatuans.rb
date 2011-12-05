class CreateZhiyoufatuans < ActiveRecord::Migration
  def change
    create_table :zhiyoufatuans do |t|
      t.references :zhiyou
      t.string :fatuanri
      t.references :star
      t.references :house
      t.string :foods
      t.integer :left
      t.integer :total
      t.integer :tonghang
      t.integer :zhike
      t.time :daystart
      t.time :dayend

      t.timestamps
    end
    add_index :zhiyoufatuans, :zhiyou_id
    add_index :zhiyoufatuans, :star_id
    add_index :zhiyoufatuans, :house_id
  end
end
