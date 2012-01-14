class CreateVolunteerHours < ActiveRecord::Migration
  def self.up
    create_table :volunteer_hours do |t|
      t.integer :user_id
      t.text :description
      t.string :v_type
      t.integer :hours
      t.datetime :v_date

      t.timestamps
    end
  end

  def self.down
    drop_table :volunteer_hours
  end
end
