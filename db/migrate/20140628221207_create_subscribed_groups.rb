class CreateSubscribedGroups < ActiveRecord::Migration
  def change
    create_table :subscribed_groups do |t|
      t.integer :user_id
      t.integer :group_id
      t.boolean :moderator, :default=>false
      t.boolean :owner, :default=>false

      t.timestamps
    end
  end
end
