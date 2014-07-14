class AddGroupToSubscribedLetter < ActiveRecord::Migration
  def change
    add_column :subscribed_letters, :group_id, :integer
  end
end
