class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.string :title
      t.string :body
      t.integer :user_id
      t.integer :post_id
      t.integer :playlist_id
      t.integer :program_id
      t.integer :interview_id
      t.integer :review_id

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
