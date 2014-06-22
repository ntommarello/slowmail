class AddCityToLetters < ActiveRecord::Migration
  def change
    add_column :letters, :city, :string
  end
end
