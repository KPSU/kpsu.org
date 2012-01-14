class AddDayToEvent < ActiveRecord::Migration
  def self.up
    add_column :events, :day_i, :integer
  end

  def self.down
    remove_column :events, :day_i
  end
end
