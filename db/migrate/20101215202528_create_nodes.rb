class CreateNodes < ActiveRecord::Migration
  def self.up
    create_table :nodes do |t|
      t.integer :uid
      t.integer :vid
      t.string :content_type
      t.string :title
      t.integer :nid
      t.integer :status
      t.integer :f_created
      t.integer :f_changed
      t.integer :nid

      t.timestamps
    end
  end

  def self.down
    drop_table :nodes
  end
end
