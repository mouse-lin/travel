class CreateLinetypesZhiyous < ActiveRecord::Migration
  def change
    create_table :linetypes_zhiyous do |t|
      t.integer :zhiyou_id
      t.integer :lientype_id

      t.timestamps
    end
  end
end
