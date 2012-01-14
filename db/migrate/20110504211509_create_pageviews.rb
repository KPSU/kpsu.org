class CreatePageviews < ActiveRecord::Migration
  def self.up
    create_table :pageviews do |t|
      t.integer :views
      t.string :page_path
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :pageviews
  end
end
