class CreateLinefatuans < ActiveRecord::Migration
  def change
    create_table :linefatuans do |t|
      t.integer :tonghang		#共用
			t.references :line
			t.integer :zhike
			t.date :daystart
			t.date :dayend
			t.string :type
	  	t.references :visatype
			t.text :document
			t.references :star       #除签证外
			t.string :fatuanri
			t.integer :left
			t.integer :total
			t.references :house #自由人、油轮使用
			t.string :foods
      t.timestamps
    end
    add_index :linefatuans, :visatype_id
    add_index :linefatuans, :line_id
    add_index :linefatuans, :star_id
    add_index :linefatuans, :house_id
  end
end
