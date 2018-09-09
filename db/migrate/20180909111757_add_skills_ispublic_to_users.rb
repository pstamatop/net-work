class AddSkillsIspublicToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :skills_ispublic, :boolean
  end
end
