class CreateTopDjs < ActiveRecord::Migration
  def self.up
    create_table :top_djs do |t|
      t.integer :user_id 
      t.integer :program_id
      t.timestamps
    end
  end

  def self.down
    drop_table :top_djs
  end
end
