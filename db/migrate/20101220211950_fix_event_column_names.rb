class FixEventColumnNames < ActiveRecord::Migration
  def self.up
    rename_column :events, :start_at, :starts_at
    rename_column :events, :end_at, :ends_at
  end

  def self.down
  end
end
