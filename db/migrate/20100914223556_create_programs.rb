class CreatePrograms < ActiveRecord::Migration
  def self.up
    create_table :programs do |t|
      t.string :title
      t.string :genre_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :programs
  end
end
