class AddVolunteerHourToComment < ActiveRecord::Migration
  def self.up
    add_column :comments, :volunteer_hour_id, :integer
  end

  def self.down
    remove_column :comments, :volunteer_hour_id
  end
end
