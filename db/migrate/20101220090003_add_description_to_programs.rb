class AddDescriptionToPrograms < ActiveRecord::Migration
  def self.up
    add_column :programs, :description, :text
  end

  def self.down
    remove_column :programs, :description
  end
end
