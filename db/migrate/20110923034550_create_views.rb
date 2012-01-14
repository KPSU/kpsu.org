class CreateViews < ActiveRecord::Migration
  def self.up
    create_table :views do |t|
      t.string :viewable_type
      t.integer :viewable_id

      t.timestamps
    end
  end

  def self.down
    drop_table :views
  end
end
