class AddTagToLetters < ActiveRecord::Migration
  def change
    add_column :letters, :to_count, :integer, :default=>1
    add_column :letters, :tag, :string
    add_column :letters, :participant_ids, :string
  end
end
