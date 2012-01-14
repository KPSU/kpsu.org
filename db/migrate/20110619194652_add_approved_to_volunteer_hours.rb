class AddApprovedToVolunteerHours < ActiveRecord::Migration
  def self.up
    add_column :volunteer_hours, :approved, :boolean
  end

  def self.down
    remove_column :volunteer_hours, :approved
  end
end
