class AddProgramIdToEvent < ActiveRecord::Migration
  def self.up
    add_column :events, :program_id, :integer
  end

  def self.down
    remove_column :events, :program_id
  end
end
