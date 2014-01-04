class AddVisibilityToProgram < ActiveRecord::Migration
  def self.up
    add_column :programs, :visible, :integer
  end

  def self.down
    remove_column :programs, :visible
  end
end
