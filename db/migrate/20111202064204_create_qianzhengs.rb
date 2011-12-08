class CreateQianzhengs < ActiveRecord::Migration
  def change
    create_table :qianzhengs do |t|
      t.references :pifa
      t.references :chufa
      t.references :linename
      t.text :detail
      t.integer :days

      t.references :dest
      t.references :visatype
      t.text :document
      t.integer :tonghang
      t.integer :zhike
      t.date :daystart
      t.date :dayend

      t.timestamps
    end
    add_index :qianzhengs, :pifa_id
    add_index :qianzhengs, :linename_id
  end
end
