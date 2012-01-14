class ChangeDataTypeForEventStartsAt < ActiveRecord::Migration
  def self.up
    change_table :events do |e|
      e.change :starts_at, :time
      e.change :ends_at, :time
    end
  end

  def self.down
  end
end
