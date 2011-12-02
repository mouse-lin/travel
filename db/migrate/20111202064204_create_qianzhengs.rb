class CreateQianzhengs < ActiveRecord::Migration
  def change
    create_table :qianzhengs do |t|
      t.references :pifa
      t.string :songqiandi
      t.string :songqianguo
      t.references :visatype
      t.text :document
      t.integer :days
      t.text :detail
      t.integer :tonghang
      t.integer :zhike
      t.time :daystart
      t.time :dayend

      t.timestamps
    end
    add_index :qianzhengs, :pifa_id
  end
end
