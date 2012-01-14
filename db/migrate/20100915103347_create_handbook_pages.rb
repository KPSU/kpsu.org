class CreateHandbookPages < ActiveRecord::Migration
  def self.up
    create_table :handbook_pages do |t|
      t.string :title
      t.text :body

      t.timestamps
    end
  end

  def self.down
    drop_table :handbook_pages
  end
end
