class AddMoreToSubscribedGroups < ActiveRecord::Migration
  def change
    add_column :subscribed_groups, :unread, :boolean, :default=>true
    add_column :subscribed_groups, :replied, :boolean, :default=>false
  end
end
