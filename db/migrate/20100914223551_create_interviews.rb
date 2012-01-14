class CreateInterviews < ActiveRecord::Migration
  def self.up
    create_table :interviews do |t|
      t.string :title
      t.text :preface
      t.text :body
      t.string :interviewee
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :interviews
  end
end
