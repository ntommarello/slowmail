class CreateLetters < ActiveRecord::Migration
  def change
    create_table :letters do |t|
      t.integer :author_id
      t.integer :receiver_id
      t.string :email
      t.string :salutation
      t.string :nickname
      t.text :content
      t.string :delivery_method
      t.datetime :delivery_date
      t.integer :views_count, :default=>0
      t.integer :hearts_count, :default=>0
      t.boolean :read, :default=>false
      t.boolean :private, :default=>true
      t.boolean :anonymous, :default=>false
      t.timestamps
    end
  end
end
