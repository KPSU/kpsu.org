class CreateCatalogs < ActiveRecord::Migration
  def self.up
    create_table :catalogs do |t|
      t.integer :number
      t.string :artist
      t.string :album
      t.string :year
      t.string :label

      t.timestamps
    end
  end

  def self.down
    drop_table :catalogs
  end
end
