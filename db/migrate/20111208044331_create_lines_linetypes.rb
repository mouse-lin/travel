class CreateLinesLinetypes < ActiveRecord::Migration
  def change
    create_table :lines_linetypes do |t|
      t.integer :line_id
      t.integer :linetype_id

      t.timestamps
    end
  end
end
