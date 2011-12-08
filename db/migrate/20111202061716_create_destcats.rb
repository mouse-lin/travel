class CreateDestcats < ActiveRecord::Migration
  def change
    create_table :destcats do |t|
      t.string :name
      t.boolean :country

      t.timestamps
    end
  end
end
