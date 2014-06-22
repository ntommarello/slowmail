class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.integer :login_count
      t.string :avatar
      t.string :provider
      t.string :uid
      t.string :oath_token
      t.datetime :oath_expires_at

      t.timestamps
    end
  end
end
