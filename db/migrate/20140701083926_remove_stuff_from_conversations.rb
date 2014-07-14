class RemoveStuffFromConversations < ActiveRecord::Migration
  def up
    remove_column :conversations, :display_user_id
    remove_column :conversations, :replied
    remove_column :conversations, :last_status_date
    remove_column :conversations, :tag
    remove_column :conversations, :count_to
  end

  def down
    add_column :conversations, :count_to, :integer
    add_column :conversations, :tag, :string
    add_column :conversations, :last_status_date, :datetime
    add_column :conversations, :replied, :boolean
    add_column :conversations, :display_user_id, :integer
  end
end
