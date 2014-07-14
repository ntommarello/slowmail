class DeleteRecieverFromLetters < ActiveRecord::Migration
  def up
  	remove_column :letters, :receiver_id
  	remove_column :letters, :read
  	remove_column :letters, :email
  	add_column :subscribed_letters, :email, :string
  end

  def down
  	add_column :letters, :receiver_id, :integer
  	add_column :letters, :read, :boolean
  	add_column :letters, :email, :string
  	remove_column :subscribed_letters, :email
  end
end