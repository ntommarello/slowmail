class AddViewToSubscribedLetter < ActiveRecord::Migration
  def change
    add_column :subscribed_letters, :read, :boolean, :default=>false
  end
end