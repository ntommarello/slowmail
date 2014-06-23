class AddSubjectToLetters < ActiveRecord::Migration
  def change
    add_column :letters, :subject, :text
  end
end
