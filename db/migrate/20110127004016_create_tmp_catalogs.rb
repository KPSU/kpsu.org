class CreateTmpCatalogs < ActiveRecord::Migration
  def self.up
    create_table :tmp_catalogs do |t|
      t.integer :nid
      t.string :artist
      t.string :album
      t.integer :year
      t.string :label
      t.integer :number

      t.timestamps
    end
  end

  def self.down
    drop_table :tmp_catalogs
  end
end
