class CreateVisatypes < ActiveRecord::Migration
  def change
    create_table :visatypes do |t|
      t.string :name

      t.timestamps
    end
  end
end
