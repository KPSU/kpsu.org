class CreatePopularThisWeeks < ActiveRecord::Migration
  def self.up
    create_table :popular_this_weeks do |t|
      t.integer :user_id 
      t.integer :program_id
      t.timestamps
    end
  end

  def self.down
    drop_table :popular_this_weeks
  end
end
