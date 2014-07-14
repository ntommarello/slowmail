class AddTagToConversations < ActiveRecord::Migration
  def change
    add_column :conversations, :tag, :string
  end
end
