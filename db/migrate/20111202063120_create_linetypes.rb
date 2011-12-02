class CreateLinetypes < ActiveRecord::Migration
  def change
    create_table :linetypes do |t|
      t.string :name

      t.timestamps
    end
  end
end
