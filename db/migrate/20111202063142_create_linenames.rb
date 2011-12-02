class CreateLinenames < ActiveRecord::Migration
  def change
    create_table :linenames do |t|
      t.string :name

      t.timestamps
    end
  end
end
