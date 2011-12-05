class CreateChujingfatuans < ActiveRecord::Migration
  def change
    create_table :chujingfatuans do |t|
      t.references :chujing
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
    add_index :chujingfatuans, :chujing_id
    add_index :chujingfatuans, :star_id
  end
end
