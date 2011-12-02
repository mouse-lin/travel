class CreatePifas < ActiveRecord::Migration
  def change
    create_table :pifas do |t|
      t.string :name

      t.timestamps
    end
  end
end
