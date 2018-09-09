class AddEducationIspublicToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :education_ispublic, :boolean
  end
end
