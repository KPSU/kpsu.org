class CreateHappenings < ActiveRecord::Migration
  def self.up
    create_table :happenings do |t|
      t.datetime :starts_at
      t.datetime :ends_at
      t.string :title
      t.text :description
      t.string :url
      t.string :contact_email

      t.timestamps
    end
  end

  def self.down
    drop_table :happenings
  end
end
