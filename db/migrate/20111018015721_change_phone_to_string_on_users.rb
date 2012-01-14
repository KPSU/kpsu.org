class ChangePhoneToStringOnUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |e|
      e.change :phone, :text
    end
  end

  def self.down
  end
end
