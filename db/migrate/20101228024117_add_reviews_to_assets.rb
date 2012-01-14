class AddReviewsToAssets < ActiveRecord::Migration
  def self.up
    add_column :assets, :review_id, :integer
  end

  def self.down
    remove_column :assets, :review_id
  end
end
