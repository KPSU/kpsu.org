class AddPromomp3ToPromos < ActiveRecord::Migration
  def self.up
    add_column :promos, :promomp3, :string
  end

  def self.down
    remove_column :promos, :promomp3
  end
end
