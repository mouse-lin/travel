class CreateStars < ActiveRecord::Migration
  def change
    create_table :stars do |t|
      t.string :name

      t.timestamps
    end
  end
end
