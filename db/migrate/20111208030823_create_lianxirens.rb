class CreateLianxirens < ActiveRecord::Migration
  def change
    create_table :lianxirens do |t|
      t.string :name
      t.string :fax
      t.string :phone
      t.string :msn
      t.string :qq
      t.string :address
      t.string :post_number
      t.references :pifa
      t.timestamps
    end
    add_index :lianxirens, :pifa_id
  end
end
