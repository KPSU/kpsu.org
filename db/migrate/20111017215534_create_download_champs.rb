class CreateDownloadChamps < ActiveRecord::Migration
  def self.up
    create_table :download_champs do |t|
      t.integer :user_id 
      t.integer :program_id
      t.timestamps
    end
  end

  def self.down
    drop_table :download_champs
  end
end
