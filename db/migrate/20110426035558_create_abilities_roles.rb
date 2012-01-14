class CreateAbilitiesRoles < ActiveRecord::Migration
  def self.up
    create_table :abilities_roles, :id => false do |t|
      t.integer :role_id
      t.integer :ability_id

      t.timestamps
    end
  end

  def self.down
    drop_table :abilities_roles
  end
end
