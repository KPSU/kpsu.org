class AddEvenMoreIndexes < ActiveRecord::Migration
  def self.up
    add_index :reviews, :id
    add_index :downloads, [:id, :user_id, :program_id]
    add_index :feeds, :id
    add_index :catalogs, :id
    
  end

  def self.down
  end
end
