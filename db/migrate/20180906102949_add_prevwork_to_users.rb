class AddPrevworkToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :prevwork, :text
  end
end
