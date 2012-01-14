class AddContentTypeIdToPost < ActiveRecord::Migration
  def self.up
    add_column :posts, :content_type_id, :integer
  end

  def self.down
    remove_column :posts, :content_type_id
  end
end
