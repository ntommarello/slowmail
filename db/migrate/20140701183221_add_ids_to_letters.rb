class AddIdsToLetters < ActiveRecord::Migration
  def change
    add_column :letters, :to_ids, :string
  end
end
