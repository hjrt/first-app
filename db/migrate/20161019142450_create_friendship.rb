class CreateFriendship < ActiveRecord::Migration[5.0]
  def change
    create_table :friendships do |t|
    	t.integer :user_id
    	t.integer :friend_id
    	t.boolean :accepted, :default => false
    end

    add_index(:friendships, [:user_id, :friend_id], :unique => true)
    add_index(:friendships, [:friend_id, :user_id], :unique => true)
  end
end
