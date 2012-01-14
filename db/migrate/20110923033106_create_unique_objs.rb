class CreateUniqueObjs < ActiveRecord::Migration
  def self.up
    create_table :unique_objs do |t|
      t.string :title
      t.string :description
      t.string :unique_objectable_type
      t.integer :unique_objectable_id

      t.timestamps
    end
  end

  def self.down
    drop_table :unique_objs
  end
end
