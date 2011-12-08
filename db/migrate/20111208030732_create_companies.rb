class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.integer :product_id

      t.timestamps
    end
    add_index :companies, :product_id
  end
end
