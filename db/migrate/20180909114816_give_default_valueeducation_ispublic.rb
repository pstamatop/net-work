class GiveDefaultValueeducationIspublic < ActiveRecord::Migration[5.1]
  def change
  	change_column :users, :education_ispublic, :boolean, default: "true"
  end
end
