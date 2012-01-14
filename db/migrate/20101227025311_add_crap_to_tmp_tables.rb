class AddCrapToTmpTables < ActiveRecord::Migration
  def self.up
    add_column :tmp_tables, :schedule_nid, :integer
    add_column :tmp_tables, :iid, :integer
    add_column :tmp_tables, :program_id, :integer
    add_column :tmp_tables, :start, :integer
    add_column :tmp_tables, :finish, :integer
    add_column :tmp_tables, :may_archive, :integer
  end

  def self.down
    remove_column :tmp_tables, :may_archive
    remove_column :tmp_tables, :finish
    remove_column :tmp_tables, :start
    remove_column :tmp_tables, :program_id
    remove_column :tmp_tables, :iid
    remove_column :tmp_tables, :schedule_nid
  end
end
