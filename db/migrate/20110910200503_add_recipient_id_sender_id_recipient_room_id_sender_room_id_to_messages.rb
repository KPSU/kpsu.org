class AddRecipientIdSenderIdRecipientRoomIdSenderRoomIdToMessages < ActiveRecord::Migration
  def self.up
    add_column :messages, :recipient_id, :string
    add_column :messages, :sender_id, :string
    add_column :messages, :recipient_room_id, :string
    add_column :messages, :sender_room_id, :string
  end

  def self.down
    remove_column :messages, :sender_room_id
    remove_column :messages, :recipient_room_id
    remove_column :messages, :sender_id
    remove_column :messages, :recipient_id
  end
end
