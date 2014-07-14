class CreateSubscribedLetters < ActiveRecord::Migration
  def change
    create_table :subscribed_letters do |t|
      t.integer :letter_id
      t.integer :user_id

      t.timestamps
    end
  end
end
