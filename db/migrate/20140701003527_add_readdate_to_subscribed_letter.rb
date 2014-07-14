class AddReaddateToSubscribedLetter < ActiveRecord::Migration
  def change
    add_column :subscribed_letters, :read_on, :datetime
  end
end
