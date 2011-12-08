class CreateLines < ActiveRecord::Migration
  def change
    create_table :lines do |t|
      t.references :pifa 
    	t.references :chufa
	  	t.references :linename
	  	t.references :product
	  	t.references :lianxiren
	  	t.references :company
	  	t.integer :days 
	  	t.text :detail
	  	t.string :type

      t.timestamps
    end
    add_index :lines, :pifa_id
    add_index :lines, :chufa_id
    add_index :lines, :linename_id
    #add_index :lines, :product_id
    add_index :lines, :lianxiren_id
    add_index :lines, :company_id
  end
end
