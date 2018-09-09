class AddCurworkIspublicToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :curwork_ispublic, :boolean
  end
end
