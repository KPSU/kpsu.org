class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :f_name
      t.string :l_name
      t.string :signature
      t.string :email
      t.text :about
      t.string :influences
      t.string :dj_name
      t.string :homepage
      t.integer :age
      t.string :gender

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
