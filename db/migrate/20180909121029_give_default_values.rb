class GiveDefaultValues < ActiveRecord::Migration[5.1]
  def change
  	change_column :users, :curwork_ispublic, :boolean, :default => true
  	change_column :users, :education_ispublic, :boolean, :default => true
  	change_column :users, :skills_ispublic, :boolean, :default => true
  end
end
