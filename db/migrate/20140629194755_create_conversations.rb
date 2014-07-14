class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.integer :sidebar_owner_id
      t.integer :display_user_id
      t.integer :count_to, :default=>1
      t.string :cc_user_ids
      t.integer :last_letter_id
      t.boolean :replied, :default=>false
      t.integer :message_count, :default=>1
      t.boolean :unread, :default=>true
      t.datetime :last_status_date

      t.timestamps
    end
  end
end
