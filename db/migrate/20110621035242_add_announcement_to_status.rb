class AddAnnouncementToStatus < ActiveRecord::Migration
  def self.up
    add_column :statuses, :announcement, :boolean
  end

  def self.down
    remove_column :statuses, :announcement
  end
end
