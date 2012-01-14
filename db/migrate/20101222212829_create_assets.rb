class CreateAssets < ActiveRecord::Migration
  def self.up
    create_table :assets do |t|
      t.string :item_file_name
      t.string :item_content_type
      t.integer :item_file_size
      t.datetime :item_updated_at
      t.string :title
      t.text :description
      t.integer :user_id
      t.integer :post_id

      t.timestamps
    end
  end

  def self.down
    drop_table :assets
  end
end
