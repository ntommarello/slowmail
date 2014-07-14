class AddDraftToLetters < ActiveRecord::Migration
  def change
    add_column :letters, :mailed, :boolean, :default=>false
    add_column :letters, :mailed_at, :datetime
  end
end