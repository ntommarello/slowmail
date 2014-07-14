class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.integer :creator_id
      t.string :name
      t.string :tagline
      t.string :avatar
      t.text :description
      t.boolean :privacy_invite_only, :default=>false
      t.boolean :privacy_members_only_view, :default=>false

      t.timestamps
    end
  end
end
