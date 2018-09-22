class CreateTskillsUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :tskills_users do |t|
      t.integer :tskill_id
      t.integer :user_id
    end
  end
end
