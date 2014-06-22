class AddDraftToUsers < ActiveRecord::Migration
  def change
    add_column :users, :draft, :text
  end
end
