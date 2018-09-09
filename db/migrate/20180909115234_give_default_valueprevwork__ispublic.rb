class GiveDefaultValueprevworkIspublic < ActiveRecord::Migration[5.1]
  def change
  	change_column :users, :prevwork_ispublic, :boolean, :default => true
  end
end
