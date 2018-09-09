class AddPrevworkIspublicToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :prevwork_ispublic, :boolean
  end
end
