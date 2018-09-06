class AddCurworkToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :curwork, :text
  end
end
