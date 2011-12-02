class CreateChufas < ActiveRecord::Migration
  def change
    create_table :chufas do |t|
      t.string :name

      t.timestamps
    end
  end
end
