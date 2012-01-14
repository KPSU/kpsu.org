class CreateTmpRevisions < ActiveRecord::Migration
  def self.up
    create_table :tmp_revisions do |t|
      t.integer :nid
      t.integer :vid
      t.integer :uid
      t.string :title
      t.text :body

      t.timestamps
    end
  end

  def self.down
    drop_table :tmp_revisions
  end
end
