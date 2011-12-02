class CreateDestcats < ActiveRecord::Migration
  def change
    create_table :destcats do |t|
      t.string :name

      t.timestamps
    end
  end
end
