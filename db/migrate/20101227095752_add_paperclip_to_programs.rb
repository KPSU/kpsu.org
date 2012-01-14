class AddPaperclipToPrograms < ActiveRecord::Migration
  def self.up
    add_column :programs, :thumb_file_name, :string
    add_column :programs, :thumb_content_type, :string
    add_column :programs, :thumb_file_size, :integer
    add_column :programs, :thumb_updated_at, :datetime
  end

  def self.down
    remove_column :programs, :thumb_updated_at
    remove_column :programs, :thumb_file_size
    remove_column :programs, :thumb_content_type
    remove_column :programs, :thumb_file_name
  end
end
