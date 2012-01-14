class CreateAbilities < ActiveRecord::Migration
  def self.up
    create_table :abilities do |t|
      t.integer :role_id
      t.string :title
      t.text :description
      t.string :url

      t.timestamps
    end
  end

  def self.down
    drop_table :abilities
  end
end
