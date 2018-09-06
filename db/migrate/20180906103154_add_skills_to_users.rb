class AddSkillsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :skills, :text
  end
end
