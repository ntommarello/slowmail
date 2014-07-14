class RemoveIdsToLetters < ActiveRecord::Migration
  def up
    remove_column :letters, :to_ids
  end

  def down
    add_column :letters, :to_ids, :string
  end
end
