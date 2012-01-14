class CreateStrikes < ActiveRecord::Migration
  def self.up
    create_table :strikes do |t|
      t.text :description
      t.integer :user_id
      t.integer :issued_by

      t.timestamps
    end
  end

  def self.down
    drop_table :strikes
  end
end
