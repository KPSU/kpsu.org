class CreateTmpTables < ActiveRecord::Migration
  def self.up
    create_table :tmp_tables do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :tmp_tables
  end
end
