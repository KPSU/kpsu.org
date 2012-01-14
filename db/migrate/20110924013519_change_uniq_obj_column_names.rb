class ChangeUniqObjColumnNames < ActiveRecord::Migration
  
  def self.up
    rename_column :unique_objs, :unique_objectable_type, :objectifiable_type
    rename_column :unique_objs, :unique_objectable_id, :objectifiable_id
  end
  
  def self.down
    
  end
  
end
