class CreateQianzhengs < ActiveRecord::Migration
  def change
    create_table :qianzhengs do |t|
      t.references :pifa
      t.string :songqiandi
      t.string :songqianguo
      t.references :visatype
      t.references :linename
      t.text :document
      t.integer :days
      t.text :detail
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
