class AddDeliveredToLetters < ActiveRecord::Migration
  def change
    add_column :letters, :delivered, :boolean, :default=>false
  end
end
