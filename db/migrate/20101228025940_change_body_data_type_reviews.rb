class ChangeBodyDataTypeReviews < ActiveRecord::Migration
  def self.up
    change_table :reviews do |e|
      e.change :body, :text
    end
  end

  def self.down
  end
end
