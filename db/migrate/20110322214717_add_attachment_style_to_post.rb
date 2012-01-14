class AddAttachmentStyleToPost < ActiveRecord::Migration
  def self.up
    add_column :posts, :attachment_style, :integer
  end

  def self.down
    remove_column :posts, :attachment_style
  end
end
